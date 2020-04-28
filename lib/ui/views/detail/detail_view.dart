import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/advanced/CurvedShape.dart';
import 'package:luvutest/advanced/LuvuContainer.dart';
import 'package:luvutest/advanced/widgets/Products.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/ui/shared/ui_helpers.dart';
import 'package:luvutest/viewmodels/detail_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DetailView extends StatefulWidget {
  final Gift gift;

  static const cardHeightFraction = .8;

  static const bottomOffset = 50;

  const DetailView({Key key, this.gift}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  double _cardHeight;
  ScrollController _scrollController;
  bool _showTitle;
  bool _showToolbarColor;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    _cardHeight =
        screenHeight * .6;

    final screenSize = MediaQuery.of(context).size;

    return ViewModelProvider<DetailViewModel>.withConsumer(
        viewModel: DetailViewModel(),
        onModelReady: (model) {model.setGift(widget.gift);model.notifyListeners();},
        builder: (context, model, child) => Scaffold(
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
                   // backgroundColor: Colors.green,
                    //backgroundColor: Theme.of(context).appBarTheme.color,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,

                      background: _buildMain(context,model),
                    ),
                  ),
                ],
                body: _getProducts(),
              ),
            ));
  }
  Widget _getProducts() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(

shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:24.0),
            child: Text("Produktempfehlungen",style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 1),),
          ),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Product(title: "Test1",title2: "Test2",rating: "blbla",img: "https://source.unsplash.com/500x500/?wearable",),
                      Product(title: "Test1",title2: "Test2",rating: "blbla",img: "https://source.unsplash.com/500x500/?products",),
                      Product(title: "Test1",title2: "Test2",rating: "blbla",img: "https://source.unsplash.com/500x500/?products,wearable",),
                      Product(title: "Test1",title2: "Test2",rating: "blbla",img: "https://source.unsplash.com/500x500/?clothing",),
                    ],
                  )

                ]
            )
          ),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width
          ),


        ],
      ),
    );
  }



  Widget _buildMain(context,DetailViewModel model) {
    final screenSize = MediaQuery.of(context).size;
    final Gift gift = model.getGift();
    final luvuSize = screenSize.width * 0.46;

    return ClipPath(
      clipper: LuvuClipper(),
      child: Stack(
        children: <Widget>[
          LuvuContainer(
            giftTop: 80,
            giftRight: 200,
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

             Container(

              margin: EdgeInsets.only(top:40),
               width:200,
               child:Row(
                 mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[

                   Expanded(
                     child: Container(
                      padding:EdgeInsets.only(left: 18),
                       child:   Text(
                         //model.getGift().name
                         model.getGift().name
                         ,
                         style: TextStyle(
                           fontSize: 30,
                           height: 0.9,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                     ),
                     flex: 3,
                   ),
                   Expanded(
                     child: Container(


                       child: Padding(
                         padding: const EdgeInsets.only(right:12.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           mainAxisSize: MainAxisSize.max,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: Text(gift.createdAt,style: TextStyle(color: Colors.grey),),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[

                                RawMaterialButton(
                                  elevation: 5.0,
                                  child: Icon(Icons.edit,color: Colors.white,size: 20,),
                                  onPressed: (){},
                                  constraints: BoxConstraints.tightFor(
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Theme.of(context).primaryColor,
                                ),
                                RawMaterialButton(
                                  elevation: 5.0,
                                  child: Icon(Icons.share,color: Colors.white,size: 20,),
                                  onPressed: (){},
                                  constraints: BoxConstraints.tightFor(
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                  shape: CircleBorder(),
                                  fillColor: Theme.of(context).primaryColor,
                                ),

                                ],
                              )
                           ],
                         ),
                       ),
                     ),
                     flex: 2,
                   ),

                 ],
               ),
             ),



            ],
          ),

         Positioned(
           bottom:100,
           left:20,
           child:  SizedBox(
             width: 100,
             height:100,
             child: Container(
                 width: 100.0,
                 height: 100.0,

                 decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.white,width: 4),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(.5),blurRadius: 10,offset: Offset.fromDirection(-1,8))
                      ],
                     image: new DecorationImage(
                         fit: BoxFit.fill,
                         image: new NetworkImage(
                             "https://randomuser.me/api/portraits/women/2.jpg")
                     )
                 )),
           ),
         )


        ],
      ),
    );
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
