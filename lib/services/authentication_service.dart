
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/models/user.dart';
import 'package:luvutest/services/ApiService.dart';
import 'package:luvutest/services/navigation_service.dart';




class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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


  Future loginAnonymous() async{
    print("Start login anonymous");
    final AuthResult result = await _firebaseAuth.signInAnonymously();

    return result;
  }

  Future loginWithGoogle() async{
    print("Start Login");
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;


    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    await _populateCurrentUser(user);
    await _apiService.createUser(currentUser);

    return user!=null;
  }


  Future loginWithEmail({
    @required String email,
    @required String password,

  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(user.user);

      return user.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String name
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _populateCurrentUser(authResult.user);
      await _apiService.createUser(currentUser);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }


  _populateCurrentUser(FirebaseUser user) async{
    if(user != null){
        IdTokenResult token = await user.getIdToken();
        _currentUser = new User(name: user.displayName,id: user.uid,token: token.token);
    }
  }
  /*Future _populateCurrentUser(FirebaseUser user) async{
    if(user != null){
        _currentUser = await _firestoreService.getUser(user.uid);
    }
  } */

  void logOut() async{

      await _firebaseAuth.signOut();
      _currentUser = null;
      _navigationService.replaceTo(LoginViewRoute);
  }

}
