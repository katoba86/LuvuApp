import 'package:flutter/material.dart';
import 'package:luvutest/constants/config.dart';

class StringIcon extends StatelessWidget {
  final String iconName;
  final Color color;



  const StringIcon(this.iconName, {this.color});



  @override
  Widget build(BuildContext context) {

    IconData _ico;

    if(ALLOWED_ICONS.containsKey(iconName)) {
      _ico = ALLOWED_ICONS[iconName];
    }else{
      _ico = DEFAULT_ICON;
    }

    /*return ColorFiltered(
      child:Image(
        image: AssetImage("assets/images/${this.iconName}.png"),
        width: 24,
      ),
      colorFilter: ColorFilter.mode(Colors.green, BlendMode.luminosity),

    ); */


    return Image(
      image: AssetImage("assets/images/${this.iconName}.png"),
      width: 24,
    );
  }
}
