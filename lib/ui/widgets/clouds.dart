import 'package:flutter/material.dart';

class Clouds extends StatefulWidget {
  @override
  _CloudsState createState() => _CloudsState();
}

class _CloudsState extends State<Clouds> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation1;
  Animation<Offset> _offsetAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(-2, 0.0),
      end: const Offset(4, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(-1.4, 0.0),
      end: const Offset(3.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SlideTransition(
          position: _offsetAnimation1,
          child: Image.asset('assets/images/c3.png', width: 150.0),
        ),
        SlideTransition(
          position: _offsetAnimation2,
          child: Image.asset('assets/images/c2.png', width: 110.0),
        )
      ],
    );
  }
}

class PositionedClouds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      left:0,
      top:20,
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Clouds(),
    );
  }
}
