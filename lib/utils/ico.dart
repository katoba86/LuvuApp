import 'package:flutter/cupertino.dart';
import 'package:luvutest/constants/config.dart';

class Ico{


  static String IconDataToString(IconData ico){
    String detected;
    ALLOWED_ICONS.forEach((String name,IconData data){
        if(data == ico){
          detected = name;
          return;
        }
    });
    return detected;
  }

}