import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LuvuContainer extends StatelessWidget {
  const LuvuContainer({
    Key key,
    @required this.children,
    this.height,
    this.navigationKey,
    this.decoration,
    this.giftTop,
    this.giftRight,
    this.appBar = false,
    this.topImage
  }) : super(key: key);

  final GlobalKey<ScaffoldState> navigationKey;
  final bool appBar;
  final List<Widget> children;
  final Decoration decoration;
  final double height;
  final Image topImage;
  final double giftTop;
  final double giftRight;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final luvuSize = screenSize.width * 0.66;


    final luvuTop = (this.giftTop==null)?-(screenSize.width * 0.154):this.giftTop;
    final luvuRight = (this.giftRight==null)?-(screenSize.width * 0.23):this.giftRight;
    final appBarTop = luvuSize / 2 + luvuTop - IconTheme.of(context).size / 2;

    return Container(

      width: screenSize.width,
      decoration: decoration,
      child: Stack(
        children: <Widget>[

          Positioned(
            bottom: 1,
            child: Container(
              width:MediaQuery.of(context).size.width,
              height:168,
              decoration: BoxDecoration(

                  image: DecorationImage(
                     fit: BoxFit.none,

                      alignment: AlignmentDirectional(1,1),
                      image: AssetImage('assets/images/wiese.png')
                  )
              ),
            ),
          ),


          Positioned(
            top: luvuTop,
            right: luvuRight,
            child: Transform.rotate(
              angle: -.7,
              child: Opacity(
                opacity: .05,
                child: (this.topImage!=null)?
                this.topImage:Container(),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (appBar)
                Padding(
                  padding: EdgeInsets.only(left: 26, right: 26, top: appBarTop),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: Navigator.of(context).pop,
                      ),
                      /*GestureDetector(
                        onTap: (){
                            this.navigationKey.currentState.openEndDrawer();
                        },
                        child:  Icon(Icons.menu),
                      )*/

                    ],
                  ),
                ),
              if (children != null) ...children,
            ],
          ),
        ],
      ),
    );
  }
}
