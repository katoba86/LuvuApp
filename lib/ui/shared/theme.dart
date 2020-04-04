import 'package:flutter/material.dart';


enum LuvuThemeKeys {DEFAULT}

class LuvuTheme{
  static Map<int, Color> color =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };


  static  Map<int, Color> getColorList(int r,int g,int b){
    Map<int, Color> map = new Map<int,Color>();
    double k = 1;
    for(int i=900;i>=0;i-=100){
      if(i==0){
        i=50;
        map[i]=Color.fromRGBO(r,g,b, .1);
        break;
      }

      map[i]=Color.fromRGBO(r,g,b,k);
      k-=.1;
    }
   return map;
  }

  static MaterialColor getShade(){
    return MaterialColor(0xFF4BBECC, getColorList(75, 190, 204));
  }

  static final ThemeData defaultTheme = ThemeData(
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,     //  <-- dark color
        textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
      ),

    //primarySwatch:getColorList(75, 190, 204),
    primarySwatch:MaterialColor(0xFF4BBECC, getColorList(75, 190, 204)),


      fontFamily: 'Comic'
  );

  static ThemeData getThemeFromKey(LuvuThemeKeys key){
    switch(key){
      case LuvuThemeKeys.DEFAULT:
        return defaultTheme;
      default:
        return defaultTheme;
    }
  }


}