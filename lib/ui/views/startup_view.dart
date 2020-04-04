import 'package:flutter/material.dart';
import 'package:luvutest/language/i18n.dart';
import 'package:luvutest/viewmodels/startup_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return ViewModelProvider<StartUpViewModel>.withConsumer(
        viewModel: StartUpViewModel(),
        onModelReady: (model)=> model.handleStartupLogic(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: Image.asset("assets/02.png"),
                  ),
                  CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation(Color(0xff990022)),)
                ],
              ),
            )));
  }
}
