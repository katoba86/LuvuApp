
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/user.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/navigation_service.dart';




class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //final FacebookSignIn _facebookSignIn = FacebookSignIn();

  final ApiService _apiService = new ApiService();
  final NavigationService _navigationService = locator<NavigationService>();

  User _currentUser;
  User get currentUser => _currentUser;

  Future<bool> isUserLoggedIn() async{
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user!=null;
  }





  Future<FirebaseUser> getUser() async{
    return await _firebaseAuth.currentUser();
  }

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }

  Future loginWithFacebook() async{

    FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookAuthCred =
      FacebookAuthProvider.getCredential(accessToken: accessToken);
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(
          facebookAuthCred);
      final FirebaseUser user = authResult.user;

      await _populateCurrentUser(user);
      await _apiService.createUser(currentUser);

      return user != null;
    }
    return null;
  }

  Future loginWithGoogle() async{

    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;


    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    await _populateCurrentUser(user);
    await _apiService.createUser(currentUser);

    return user!=null;
  }




  _populateCurrentUser(FirebaseUser user) async{
    if(user != null){
        IdTokenResult token = await user.getIdToken();
        _currentUser = new User(name: user.displayName,id: user.uid,token: token.token);
    }
  }

  void logOut() async{

      await _firebaseAuth.signOut();
      _currentUser = null;
      _navigationService.replaceTo(LoginViewRoute);
  }

}
