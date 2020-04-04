
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luvutest/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/ui/shared/theme.dart';
import 'package:luvutest/ui/views/home_view.dart';
import 'package:luvutest/ui/views/login_view.dart';

import 'package:luvutest/ui/views/startup_view.dart';
import 'language/i18n.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';

void main() {

 // Register all the models and services before the app starts
 setupLocator();

  runApp(MyApp());

}


class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {

  SystemChrome.setPreferredOrientations([
   DeviceOrientation.portraitUp,
   DeviceOrientation.portraitDown,
  ]);

  return MaterialApp(
   debugShowCheckedModeBanner: false,
   localizationsDelegates: [
    const I18nDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
   ],
   supportedLocales: I18nDelegate.supportedLocals,
   title: 'Luvu',
   builder: (context, child){
    return Navigator(
    key: locator<DialogService>().dialogNavigationKey,
    onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => DialogManager(child: child)),
   );},
   navigatorKey: locator<NavigationService>().navigationKey,
   theme: LuvuTheme.defaultTheme,
   home: StartupView(),
   onGenerateRoute: generateRoute,
  );
 }
}
