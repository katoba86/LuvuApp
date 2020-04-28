
import 'package:flutter/material.dart';
import 'package:luvutest/advanced/AppColors.dart';

class NewHomeCard extends StatelessWidget {
  const NewHomeCard(
      this.info, {
        Key key,
        this.onPress,
      }) : super(key: key);

  final List<String> info;
  final Function onPress;


  final Color cardColor = AppColors.cardColor;

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          info[0],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDecorations(double itemHeight,double itemWidth) {
    return [
      Positioned(
        top: -itemHeight * 0.616,
        left: -itemHeight * 0.53,
        child: CircleAvatar(
          radius: itemHeight * 1.03 / 2,
          backgroundColor: Colors.white.withOpacity(0.14),
        ),
      ),
      Positioned(
        top: 10,
        left: itemWidth/2-itemHeight*.7/2,
        child: Image.asset(
          this.info[1],
          width: itemHeight * .7,
          //height: itemHeight * 1.388,
        //color:AppColors.grey.withOpacity(.2)

        ),
      ),

    ];
  }

  Widget _buildShadow(double itemWidth) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: itemWidth * 0.82,
        height: 11,

        decoration: BoxDecoration(

          boxShadow: [
            BoxShadow(
              color:cardColor,
              offset: Offset(0, 3),
              blurRadius: 23,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;
        final itemWidth = constrains.maxWidth;

        return Stack(
          children: <Widget>[
            _buildShadow(itemWidth),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(0),
              color: cardColor,
              splashColor: Colors.white10,
              highlightColor: Colors.white10,
              elevation: 0,
              highlightElevation: 2,
              disabledColor: cardColor,
              onPressed: onPress,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    ..._buildDecorations(itemHeight,itemWidth),
                    _buildCardContent(),

                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}