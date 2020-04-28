
import 'package:flutter/material.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/ui/widgets/slide_up_panel.dart';
import 'package:luvutest/viewmodels/detail_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';




class DetailView extends StatefulWidget {
  Gift currentGift;

  DetailView({Key key, this.currentGift});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> with TickerProviderStateMixin {
  static const double _pokemonSlideOverflow = 20;

  AnimationController _cardController;
  AnimationController _cardHeightController;
  double _cardMaxHeight = 0.0;
  double _cardMinHeight = 0.0;
  GlobalKey _pokemonInfoKey = GlobalKey();

  @override
  void dispose() {
    _cardController.dispose();
    _cardHeightController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _cardController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _cardHeightController = AnimationController(vsync: this, duration: Duration(milliseconds: 220));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      final appBarHeight = 60 + 22 + IconTheme.of(context).size;

      final RenderBox pokemonInfoBox = _pokemonInfoKey.currentContext.findRenderObject();

      _cardMinHeight = screenHeight - pokemonInfoBox.size.height + _pokemonSlideOverflow;
      _cardMaxHeight = screenHeight - appBarHeight;

      _cardHeightController.forward();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DetailViewModel>.withoutConsumer(
        viewModel: DetailViewModel(),
        onModelReady: (model) {
          model.setGift(widget.currentGift);
          model.initAnimations();
        },
      builder: (context, model, _) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
        ),
        body: Stack(

          children: <Widget>[
            AnimatedBuilder(
              animation: _cardHeightController,
              child: Container(child: Text('hello'),color: Colors.red,height:400),
              builder: (context, child) {
                return SlidingUpPanel(
                  controller: _cardController,
                  minHeight: _cardMinHeight * _cardHeightController.value,
                  maxHeight: _cardMaxHeight,
                  child: child,
                );
              },
            )



            , DescriptionSection()],
        ),
      ),

    );
  }
}


class DescriptionSection extends ProviderWidget<DetailViewModel> {
  @override
  Widget build(BuildContext context, DetailViewModel model) {
    return Row(
      children: <Widget>[
        Text(
          'Description',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        Container(
          child: Text('description'),
        ),
      ],
    );
  }
}