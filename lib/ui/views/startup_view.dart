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
                    child: Image.asset("assets/images/gift.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:40.0),
                    child: CircularProgressIndicator(strokeWidth: 8,valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),),
                  )
                ],
              ),
            )));
  }
}
