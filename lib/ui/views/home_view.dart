import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/language/i18n.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/painter/DefaultPaint.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/ui/widgets/clouds.dart';

import 'package:luvutest/viewmodels/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';




class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  double position = 0;

  NavigationService _navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {
    I18n t = I18n.of(context);


    final  List<String> cardTexts = [
      'Gemerkte Geschenke',
      'Schon zugewiesen',
      'Meine Gruppen',
      'Nach Anlass',
    ];

    final  List<AssetImage> cardImages = [
      AssetImage('assets/images/04_03.png'),
      AssetImage('assets/images/dd.png'),
      AssetImage('assets/images/06_06.png'),
      AssetImage('assets/images/06_06.png'),
    ];

    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        onModelReady: (model){ model.initAnimations();},
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
                    width: double.infinity,
                    margin: EdgeInsets.only(top:40),
                    child: Text('LUVU',style:TextStyle(fontSize: 48,color: Colors.white,shadows: [
                      Shadow(color: Colors.black.withAlpha(190),blurRadius: 16,offset: Offset(2, 1)),
                      Shadow(color: Colors.cyan.withAlpha(120),blurRadius: 4),
                    ]),textAlign: TextAlign.center,),
                  ),

                  Container(

                    margin: EdgeInsets.only(top: 80),
                    child: GridView.builder(

                      itemCount: 4,
                      shrinkWrap: false,
                      primary: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 8.0 / 10.0,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {

                        return HomeCard(cardTexts[index],Theme.of(context).primaryColor,cardImages[index],index);
                      },
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
            )));
  }



}



class HomeCard extends StatelessWidget {
  final String text;
  final AssetImage img;
  final Color color;
  final int id;


  HomeCard(this.text,this.color,this.img,this.id);
  NavigationService _navigationService = locator<NavigationService>();

  void navigateTo(int index){
    print("navigate to");
    switch(index){

      case 0:
        _navigationService.navigateTo(SavedGiftsViewRoute);
        break;

      default:
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child:Card(

          color: Color.fromARGB(255, 51, 178, 186),
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            clipBehavior: Clip.antiAlias,
            child:

            InkWell(
                splashColor: Colors.white,
                onTap: (){this.navigateTo(this.id);},
                child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0,top:16,right:16),
                      child: Container(

                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: this.img,
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom:20.0),
                    child: Center(
                      child: Text(
                        this.text,
                        textAlign:TextAlign.center,
                        style: TextStyle(fontSize: 18.0,color: Colors.white),
                      ),
                    )),
              ],
            ))));
  }
}
