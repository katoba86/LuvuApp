import 'package:luvutest/models/gift.dart';
import 'package:luvutest/ui/views/create_gift_view.dart';
import 'package:luvutest/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/ui/views/login_view.dart';
import 'package:luvutest/ui/views/saved_gifts_view.dart';
import 'package:luvutest/ui/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case CreateGiftViewRoute:
      var giftToEdit = settings.arguments as Gift;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateGiftView(
          edittingGift: giftToEdit,
        ),
      );
    case SavedGiftsViewRoute:
      bool reload = settings.arguments as bool;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SavedGiftsView(
          reload:reload
        ),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(

        ),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
