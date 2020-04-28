import 'package:flutter/material.dart';
import 'package:luvutest/advanced/CurvedShape.dart';
import 'package:luvutest/advanced/LuvuContainer.dart';
import 'package:luvutest/advanced/widgets/Invites.dart';
import 'package:luvutest/advanced/widgets/NewHomeCard.dart';
import 'package:luvutest/constants/route_names.dart';
import 'package:luvutest/locator.dart';
import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/viewmodels/home_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CardList extends StatelessWidget {
  final List<List<String>> cards = [
    ['Mein Merkzettel', 'assets/images/04_03.png', SavedGiftsViewRoute],
    ['Meine Listen', 'assets/images/dd.png', ListsViewRoute],
    ['Neue Liste', 'assets/images/06_06.png', NewListViewRoute],
    ['Einstellungen', 'assets/images/04_03.png', SettingsViewRoute],
  ];

  NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 12,
      ),
      padding: EdgeInsets.only(left: 28, right: 28, bottom: 58),
      itemCount: cards.length,
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        return
          Hero(
            tag: "cardindex_$index",
            flightShuttleBuilder: (
                BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext,
                ) {
              final Hero toHero =toHeroContext.widget;
              return ScaleTransition(
                scale: animation,
                //opacity: animation,
                child: toHero.child,
              );
            },
            child:   Material(type: MaterialType.transparency,child:NewHomeCard(cards[index],
                onPress: () => _navigationService.navigateTo(cards[index][2]))),
          )          ;

      },
    );
  }
}

class HomeView extends StatefulWidget {
  static const cardHeightFraction = .8;

  static const bottomOffset = 50;
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  NavigationService _navigationService = locator<NavigationService>();


  double _cardHeight;
  ScrollController _scrollController;
  bool _showTitle;
  bool _showToolbarColor;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    _cardHeight =
        screenHeight * HomeView.cardHeightFraction + HomeView.bottomOffset;

    final screenSize = MediaQuery.of(context).size;

    final luvuSize = screenSize.width * 0.66;

    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        onModelReady: (model) {},
        builder: (context, model, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                foregroundColor: Colors.white,
                onPressed: () {
                  model.goTo(CreateGiftViewRoute);
                },
              ),
              //floatingActionButtonLocation: FloatingActionButtonLocation.,

              // bottomNavigationBar: LuvuAppBar(),

              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              body: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (_, __) => [
                  SliverAppBar(
                    expandedHeight: _cardHeight,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    shape: CustomShapeBorder(),
                    backgroundColor: Theme.of(context).appBarTheme.color,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      title: _showTitle
                          ? Text(
                              "Luvu",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : SizedBox(height: 1),
                      background: _buildCard(context),
                    ),
                  ),
                ],
                body: _buildInvites(),
              ),
            ));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);

    super.dispose();
  }

  @override
  void initState() {
    _cardHeight = 0;
    _showTitle = false;
    _showToolbarColor = false;
    _scrollController = ScrollController()..addListener(_onScroll);

    super.initState();
  }

  Widget _buildCard(context) {
    final screenSize = MediaQuery.of(context).size;

    final luvuSize = screenSize.width * 0.66;

    return ClipPath(
      clipper: LuvuClipper(),
      child: LuvuContainer(
        topImage: Image.asset(
          "assets/images/gift-box2.png",
          width: luvuSize,
          height: luvuSize,
        ),
        decoration: BoxDecoration(

            //borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
        children: <Widget>[
          SizedBox(height: 80),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              "Geschenke\nschon vergessen?",
              style: TextStyle(
                fontSize: 30,
                height: 0.9,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(height: 42),
          CardList(),
        ],
      ),
    );
  }

  Widget _buildInvites() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[

        Padding(
            padding:
                const EdgeInsets.only(left: 28, right: 28, top: 0, bottom: 22),
            child: Text(
              "Ausstehende Einladungen",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            )),
        Invites()
      ],
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final showTitle = _scrollController.offset > _cardHeight - kToolbarHeight;

    final showToolbarColor = _scrollController.offset > kToolbarHeight;

    if (showTitle != _showTitle || showToolbarColor != _showToolbarColor) {
      setState(() {
        _showTitle = showTitle;
        _showToolbarColor = showToolbarColor;
      });
    }
  }
}
