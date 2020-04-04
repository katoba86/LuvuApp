import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/language/i18n.dart';
import 'package:luvutest/painter/DefaultPaint.dart';
import 'package:luvutest/ui/widgets/clouds.dart';
import 'package:luvutest/ui/widgets/gift_item.dart';

import 'package:luvutest/viewmodels/home_view_model.dart';
import 'package:luvutest/viewmodels/saved_gifts_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';




class SavedGiftsView extends StatefulWidget {



  const SavedGiftsView({Key key,bool reload}) : super(key: key);

  @override
  _SavedGiftsViewState createState() => _SavedGiftsViewState();
}

class _SavedGiftsViewState extends State<SavedGiftsView> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  double position = 0;
  bool reload = false;

  Future<Null> _refresh(SavedGiftsViewModel model) async {
    model.setBusy(true);
   return model.reloadGifts().then((_){
     print("yes?");
     model.setBusy(false);
   });
  }


  @override
  Widget build(BuildContext context) {
    I18n t = I18n.of(context);
    if(reload==true){
      (Logger()).i("Reload request");
    }

    return ViewModelProvider<SavedGiftsViewModel>.withConsumer(
        viewModel: SavedGiftsViewModel(),
        onModelReady: (model){model.initAnimations();model.getInitialGifts();},
        builder: (context, model, child) => Scaffold(


      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        elevation: 0,
        focusElevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        foregroundColor: Colors.transparent,

        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        backgroundColor: Colors.transparent,

        onPressed: () {

          model.goTo(CreateGiftViewRoute);

        },
        child: Icon(Icons.add),
      ),
            appBar: AppBar(
              iconTheme: IconThemeData.fallback().copyWith(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                'Gemerkte Geschenkideen',
                style: TextStyle(color: Colors.white),
              ),
            ),
                body: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: ()=>_refresh(model),
                  child: CustomPaint(
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
                      width: double.infinity,
                      margin: EdgeInsets.only(top:40),
                      child: Text('LUVU',style:TextStyle(fontSize: 48,color: Colors.white,shadows: [
                        Shadow(color: Colors.black.withAlpha(190),blurRadius: 16,offset: Offset(2, 1)),
                        Shadow(color: Colors.cyan.withAlpha(120),blurRadius: 4),
                      ]),textAlign: TextAlign.center,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:100.0),
                      child: SafeArea(
                        child: Column(
                          children: <Widget>[

                            Expanded(
                                child: model.gifts != null
                                    ? ListView.builder(
                                  itemCount: model.gifts.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                        onTap: (){
                                          print("nothing?");
                                        },
                                        child: GiftItem(
                                          post: model.gifts[index],
                                          onDeleteItem: () => model.deleteGift(index),
                                          onEditItem: (){
                                            model.editPost(index);
                                          },
                                        ),
                                      ),
                                )
                                    : Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor),
                                  ),
                                ))


                          ],
                        ),
                      ),
                    )

                    ,

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
                              right: model.position1,
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
            ),
                )));
  }
}