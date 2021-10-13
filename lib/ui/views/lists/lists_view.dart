import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:luvutest/advanced/LuvuContainer.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/ui/shared/LuvuDrawer.dart';
import 'package:luvutest/ui/widgets/ListsItem.dart';
import 'package:luvutest/viewmodels/Lists_view_model.dart';
import 'package:luvutest/viewmodels/saved_gifts_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ListsView extends StatefulWidget {
  bool reload = false;

  ListsView({this.reload});

  @override
  _ListsViewState createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  NavigationService _navigationService = locator<NavigationService>();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  Future<Null> _refresh(ListsViewModel model) async {
    model.setBusy(true);
    return model.reloadList().then((_) {
      print("yes?");
      model.setBusy(false);
    });
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final luvuSize = screenSize.width * 0.66;

    return ViewModelProvider<ListsViewModel>.withConsumer(
        viewModel: ListsViewModel(),
        onModelReady: (model) {
          model.getInitialLists();
          model.notifyListeners();
        },
        builder: (context, model, child) =>Scaffold(
            key: _drawerKey,
            endDrawer: LuvuDrawer(


                child: ListView(
                  // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Text('test')
                    ])


            ),
            floatingActionButton: FabCircularMenu(
                ringDiameter: screenSize.width*.8,
                ringWidth: screenSize.width*.8*.2,
                fabSize: 48,
                ringColor: Colors.lightGreen.shade500.withOpacity(.8),
                fabColor: Colors.white,
                fabOpenIcon: Icon(Icons.add),
                children: <Widget>[
                  IconButton(icon: Icon(Icons.home), color: Colors.white,onPressed: () {
                    _navigationService.replaceTo(HomeViewRoute);
                  }),
                  IconButton(icon: Icon(Icons.add), color: Colors.white,onPressed: () {
                    _navigationService.navigateTo(CreateGiftViewRoute);
                  }),
                  IconButton(icon: Icon(Icons.list), color: Colors.white,onPressed: () {

                  }),

                ]
            ),
            body: RefreshIndicator(
              onRefresh: () => _refresh(model),
              key:_refreshIndicatorKey,
              child: Stack(children: <Widget>[
                LuvuContainer(
                    navigationKey: _drawerKey,
                    topImage: Image.asset(
                      "assets/images/gift-box2.png",
                      width: luvuSize,
                      height: luvuSize,
                    ),
                    appBar: true,
                    children: <Widget>[
                      SizedBox(height: 34),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.0),
                        child: Hero(
                          tag: "cardindex_0",
                          flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                              ) {
                            final Hero toHero = toHeroContext.widget;
                            return ScaleTransition(
                              scale: animation,
                              //opacity: animation,
                              child: toHero.child,
                            );
                          },
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              "Meine Listen",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                      ,
                      SizedBox(height: 32),

                      Expanded(

                        child:  ListView.builder(
                          itemCount: model.lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              delay: const Duration(milliseconds:400),
                              position: index,
                              duration: const Duration(milliseconds: 1000),
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: GestureDetector(onTap:(){model.viewList(index);},child: ListsItem(list: model.lists[index] ,onDeleteItem: (){},)),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                    ])

                ,

              ]),
            )));
  }
}

