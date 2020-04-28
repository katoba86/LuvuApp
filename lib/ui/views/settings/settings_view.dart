import 'package:flutter/material.dart';
import 'package:luvutest/advanced/LuvuContainer.dart';
import 'package:luvutest/viewmodels/SettingsViewModel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class SettingsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final  TextStyle smallText = TextStyle(fontSize: 14);

    return ViewModelProvider<SettingsViewModel>.withConsumer(
        viewModel: SettingsViewModel(),
        builder: (context, model, child) =>
            Scaffold(
              appBar: AppBar(title: Text('Einstellungen'),),
              body:LuvuContainer(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 24),
                    child: Text('Gruppen-Einstellungen',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),),
                  ),
                  SwitchListTile(
                    value: model.receiveNotifications,
                    subtitle: Text('z.B. beim Hinzufügen von neuen Geschenken'),
                    title: Text("Benachrichtigungen",style: smallText),
                    onChanged: (value){model.receiveNotifications = value;},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 24,bottom: 24),
                    child: Text('Allgemeine Einstellungen',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),),
                  ),
                  SwitchListTile(
                    value: model.receiveProducts,
                    subtitle: Text('hierdurch wird auf alternative Werbung umgestellt'),
                    title: Text("Produktempfehlungen erhalten",style: smallText),
                    onChanged: (value){model.receiveProducts = value;},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 24,bottom: 24),
                    child: Text('Nutzer-Einstellungen',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){},
                          color: Colors.grey,
                          child: Text('Ausloggen'),
                        ),
                        RaisedButton(
                          onPressed: (){model.deleteAccount();},
                          child: Text('Account löschen'),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  )
                ],
              )
            )
    );
  }
}
