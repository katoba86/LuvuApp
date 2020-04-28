import 'package:flutter/material.dart';

import 'package:luvutest/painter/DefaultPaint.dart';
import 'package:luvutest/ui/shared/ui_helpers.dart';

import 'package:luvutest/ui/widgets/clouds.dart';
import 'package:luvutest/ui/widgets/login_button.dart';
import 'package:luvutest/viewmodels/login_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
        viewModel: LoginViewModel(),
        builder: (context, model, child) => Scaffold(

            body: CustomPaint(
              painter: DefaultPaint(),
              child: Stack(
                children: <Widget>[

                  Positioned(
                    left:0,
                    top:20,
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: Clouds(),
                  ),


                  Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 140),
                    child: Center(
                      child: Column(
                        children: <Widget>[

                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top:40),
                            child: Text('LUVU',style:TextStyle(fontSize: 48,color: Colors.white,shadows: [
                              Shadow(color: Colors.black.withAlpha(190),blurRadius: 16,offset: Offset(2, 1)),
                              Shadow(color: Colors.cyan.withAlpha(120),blurRadius: 4),
                            ]),textAlign: TextAlign.center,),
                          ),
verticalSpaceLarge,
                          LoginButtonBuilder(
                            width:MediaQuery.of(context).size.width*0.8,
                            height:48,
                            text: 'Weiter geht\'s mit Google',
                            image: Image(
                              image: AssetImage(
                                'assets/icons/google_light.png',
                              ),
                              height: 36.0,
                            ),
                            onPressed: (){
                              model.signUpWithGoogle();
                            },
                          ),
                          verticalSpaceSmall,
                          LoginButtonBuilder(
                            width:MediaQuery.of(context).size.width*0.8,
                            height:48,
                            text: 'Weiter geht\'s mit Apple',
                            image: Image(
                              image: AssetImage(
                                'assets/icons/apple.png',
                              ),
                              height: 36.0,
                            ),
                            onPressed: ()=>{},
                          ),
                          verticalSpaceSmall,
                          LoginButtonBuilder(
                            width:MediaQuery.of(context).size.width*0.8,
                            height:48,
                            text: 'Weiter geht\'s mit Facebook',
                            image: Image(
                              image: AssetImage(
                                'assets/icons/facebook.png',
                              ),
                              height: 36.0,
                            ),
                            onPressed: ()=> model.signUpWithFacebook(),
                          ),



                        ],
                      ),
                    )
                  ),

                  Positioned(
                      child: Stack(
                        children: <Widget>[
                         Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: AssetImage("assets/images/wiese.png"),
                                  fit: BoxFit.cover,

                                ),
                              )),
                          AnimatedPositioned(
                            duration: Duration(seconds: 1),
                            curve: Curves.easeOut,
                            right: 0,
                            top:20,
                            width:100,
                            child: Image.asset('assets/images/gift.png'),
                          ),
                        ],
                      ),
                      left: 0,
                      bottom: 0),



                ],
              ),
            )));
  }
}
