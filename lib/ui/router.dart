import 'package:luvutest/models/Lists.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/ui/views/addGift/add_gift_view.dart';
import 'package:luvutest/ui/views/detail/detail_view.dart';
import 'package:luvutest/ui/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/ui/views/lists/lists_view.dart';
import 'package:luvutest/ui/views/login_view.dart';
import 'package:luvutest/ui/views/mygifts/myGifts_view.dart';
import 'package:luvutest/ui/views/settings/settings_view.dart';



Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SettingsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SettingsView(),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case CreateGiftViewRoute:
      var giftToEdit = settings.arguments as Gift;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AddGiftView(
          //edittingGift: giftToEdit,
        ),
      );
    case DetailViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DetailView(
          gift:settings.arguments as Gift,
        ),
      );
    case SavedGiftsViewRoute:
      bool reload;
      Lists listToView;
      Map<String,dynamic> given = settings.arguments as Map<String,dynamic>;
      if(given!=null && given.containsKey("reload")){
        reload = given["reload"] as bool;
      }else{
        reload = false;
      }

      if(given!=null && given.containsKey("list")){
        listToView = given["list"] as Lists;
      }else{
        listToView = null;
      }

      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MyGiftsView(
          reload:reload,
          customList:listToView
        ),
      );
    case ListsViewRoute:
      bool reload;
      Map<String,dynamic> given = settings.arguments as Map<String,dynamic>;
      if(given!=null && given.containsKey("reload")){
        reload = given["reload"] as bool;
      }else{
        reload = false;
      }



      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ListsView(
            reload:reload,
        ),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
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

  return PageRouteBuilder(
    settings: RouteSettings(
      name: routeName
    ),
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> secAnimation,Widget child){
        animation = CurvedAnimation(parent:animation,curve:Curves.easeInOutQuart);

        return FadeTransition(
         opacity: animation,

          child: child,
        );
      },
      pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secAnimation){
        return viewToShow;
      }
  );

}
