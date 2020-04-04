import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/painter/DefaultPaint.dart';
import 'package:luvutest/ui/shared/ui_helpers.dart';
import 'package:luvutest/ui/widgets/ContactWidget.dart';
import 'package:luvutest/ui/widgets/clouds.dart';
import 'package:luvutest/viewmodels/create_gift_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreateGiftView extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final Gift edittingGift;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CreateGiftView({Key key, this.edittingGift}) : super(key: key);


  CreateGiftViewModel _tmpModel;

  void getContact(CreateGiftViewModel model) async{
    this._tmpModel = model;
    _scaffoldKey.currentState.openEndDrawer();
  }

  void getSelectedContact(input) async{
    print("Selection received");
    print(input);
    this._tmpModel.formContact = input;
    this._tmpModel.notifyListeners();
    this._tmpModel=null;
  }



  @override
  Widget build(BuildContext context) {






    return ViewModelProvider<CreateGiftViewModel>.withConsumer(
        viewModel: CreateGiftViewModel(),
        onModelReady: (model) {
          titleController.text = edittingGift?.name ?? '';
          descriptionController.text = edittingGift?.description ?? '';
          dateController.text = edittingGift?.get_up_to ?? '';
          model.setEdittingGift(edittingGift);
        },
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            drawerEdgeDragWidth: 0,

            endDrawer: Container(
                width: MediaQuery.of(context).size.width*.8,
                child: Drawer(

                    child: ListView(

                        padding: EdgeInsets.zero,
                        children: <Widget>[
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                            ),
                            child: Text(
                              'Welchem Kontakt zuweisen?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),


                          Container(
                              height:500,

                              width:double.infinity,
                              child:   ContactsList(retFunc:getSelectedContact)
                          ),


                        ]
                    ))
            ),
            appBar: AppBar(
              actions: <Widget>[
                Container()
              ],
              iconTheme: IconThemeData.fallback().copyWith(
                color: Colors.white,
              ),
              centerTitle: true,
              title: Text(
                'Neue Geschenkidee',
                style: TextStyle(color: Colors.white),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (!model.busy) {
                  model.addGift(
                      title: titleController.text,
                      description: descriptionController.text,
                      date:model.formDate,
                      contact:model.formContact);
                }
              },
              child: Icon(Icons.check),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: CustomPaint(
                painter: DefaultPaint(),
                child: Container(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Positioned(
                        left: 0,
                        top: 20,
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: Clouds(),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom:100),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 3.0,
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(28))),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: titleController,
                                      decoration: const InputDecoration(
                                        hintText: 'Name der Idee',
                                      ),
                                      autofocus: false,
                                    ),
                                    verticalSpaceMedium,
                                    TextFormField(
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                        hintText: 'Beschreibung',
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    verticalSpaceMedium,
                                    TextFormField(
                                      controller: dateController,

                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Kein Enddatum',
                                        suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              dateController.text = null;
                                              model.formDate = null;
                                            }),
                                      ),
                                      onTap: () {
                                        getDate(context, model);
                                      },
                                    ),
                                  ],
                                ),
                              ),


                                   Container(
                                     height:60,
                                     child: ListTile(
                                       onTap: (){print("hello from list Tile");},
                                       isThreeLine: false,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                        leading: Container(
                                          padding: EdgeInsets.only(top:4),

                                          child: Icon(Icons.streetview, color: Colors.grey),
                                        ),
                                        title: Text(
                                          "Thema zuordnen",
                                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text("z.B. Weihnachten", style: TextStyle(color: Colors.grey)),


                                        trailing:IconButton(onPressed: (){print("huhu from icon");},icon:
                                        Icon(Icons.clear, color: Colors.white, size: 24.0))),
                                   )
                                  ,
                              Container(
                                height:60,
                                child: ListTile(

                                    isThreeLine: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(top:4),

                                      child: Icon(Icons.camera_alt, color: Colors.grey),
                                    ),
                                    title: Text(
                                      "Bild auswählen",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("Noch nicht ausgewählt", style: TextStyle(color: Colors.grey)),


                                    trailing:
                                    Icon(Icons.clear, color: Colors.white, size: 24.0)),
                              )
                              ,
                              Container(
                                child: ListTile(
                                    onTap: (){getContact(model);},
                                    isThreeLine: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(top:4),
                                      child: Icon(Icons.people, color:  model.formContact!=null?Colors.lightGreen:Colors.grey),
                                    ),
                                    title: Text(
                                      "Für wen ist es?",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:        model.formContact!=null ? Text("Für ${model.formContact.displayName}"):Text("Noch nicht ausgewählt", style: TextStyle(color: Colors.grey)),


                                    trailing: IconButton(onPressed: (){model.formContact=null;model.notifyListeners();},icon:
                                    Icon(Icons.clear, color:  model.formContact!=null ? Colors.grey:Colors.white, size: 24.0))),
                              )






                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                      AssetImage("assets/images/wiese.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              AnimatedPositioned(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeOut,
                                right: model.position1,
                                top: 20,
                                width: 100,
                                child: Image.asset('assets/images/gift.png'),
                              ),
                            ],
                          ),
                          left: 0,
                          bottom: 0),
                    ])))));
  }

  Future<void> getDate(BuildContext context, CreateGiftViewModel model) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null) {
      model.formDate = DateFormat("yyyy-MM-dd").format(picked);
      String localeDate = DateFormat("dd.MM.yyyy").format(picked);
      dateController.text = "bis zum $localeDate";
      model.notifyListeners();
    }
  }
}
