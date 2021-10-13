import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:luvutest/advanced/LuvuContainer.dart';
import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/gift.dart';
import 'package:luvutest/services/ContactService.dart';
import 'package:luvutest/ui/shared/ui_helpers.dart';
import 'package:luvutest/ui/widgets/busy_overlay.dart';
import 'package:luvutest/viewmodels/AddGiftViewModel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class AddGiftView extends StatefulWidget {

  Gift edittingGift;

  AddGiftView({Key key, this.edittingGift}){

    if(this.edittingGift==null){
      this.edittingGift=new Gift(id:null, name: null);
    }
    //super(key: key);
  }

  @override
  _AddGiftViewState createState() => _AddGiftViewState();
}

class _AddGiftViewState extends State<AddGiftView> {
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();
  ValueChanged _onChanged = (val) => print(val);
  ContactService _contactService = new ContactService();




  @override
  Widget build(BuildContext context) {
    
    
    
    
    return ViewModelProvider<AddGiftViewModel>.withConsumer(
    viewModel: AddGiftViewModel(),
    onModelReady: (model) {


      model.setEdittingGift((widget.edittingGift==null)?new Gift(id: null, name: null):widget.edittingGift);

    },
    builder: (context, model, child) => Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!model.busy2) {
              model.addGift();
          }
        },
        backgroundColor: Colors.white,
        child: !model.busy2
            ? Icon(Icons.check)
            : CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
        foregroundColor: Theme.of(context).primaryColor,
      ),
        body: BusyOverlay(

          show: model.busy,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/images/wiese.png'),
                fit: BoxFit.contain
              )
            ),

            child: CustomScrollView(


              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 120,
                  snap: true,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                   titlePadding: EdgeInsets.only(left:0),
                    title:    Padding(
                      padding: EdgeInsets.only(left:28,right:28,top:40,bottom:0),
                      child: Text(
                        "Neues Geschenk\nhinzufügen",
                        style: TextStyle(
                          fontSize: 20,
                          height: 0.9,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),

                SliverList(

                  delegate: SliverChildListDelegate.fixed(
                    [








                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FormBuilder(
// context,
                            key: _fbKey,

                            child: Column(children: <Widget>[
                              FormBuilderTextField(
                                name:'age',
                                decoration: InputDecoration(
                                  labelText: "Name der Geschenkidee",
                                ),
                                onChanged: (val){
                                    model.editList["name"]=val;
                                },
                                valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.min(context,3),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                              verticalSpaceMedium,
                              FormBuilderTypeAhead(

                                suggestionsBoxDecoration:
                                SuggestionsBoxDecoration(elevation: 0.0),
                                transitionBuilder: (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                noItemsFoundBuilder: (BuildContext context) => Text(
                                    'Nix Gefunden',
                                    style: TextStyle(color: Colors.green)),
                                errorBuilder: (BuildContext context, Object error) =>
                                    Text('$error', style: TextStyle(color: Colors.green)),
                                decoration: InputDecoration(
                                  labelText: "Für wen ist das Geschenk?",
                                ),
//initialValue: contacts[0],
                                name: 'contact_person',
                                onChanged: _onChanged,
                                itemBuilder: (context, contact) {
                                  return ListTile(

                                    title: Text(contact.displayName),
//subtitle: Text(contact.email),
                                  );
                                },
                                selectionToTextTransformer: (c) => c.displayName,
                                suggestionsCallback: (query) {
                                  if (query.length != 0) {
                                    var lowercaseQuery = query.toLowerCase();
                                    return _contactService.where(lowercaseQuery);

                                  } else {
                                    return _contactService.getContacts();
                                  }
                                },
                              ),



                              verticalSpaceMedium,

                              Container(
                                height:60,
                                child: ListTile(
                                    onTap: (){model.selectImage(context);},
                                    isThreeLine: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    leading: Container(
                                      padding: EdgeInsets.only(top:4),

                                      child: Icon(Icons.camera_alt, color:  model.getGift().isImageGift()?Colors.lightGreen:Colors.grey),
                                    ),
                                    title: Text(
                                      model.getGift().isImageGift()?"Bild gesetzt":"Bild auswählen",
                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(model.getGift().isImageGift()?"Ändern?":"Noch nicht ausgewählt", style: TextStyle(color: Colors.grey)),


                                    trailing: IconButton(onPressed: (){
                                      model.removeImage();
                                    },icon:
                                    Icon(model.getGift().isImageGift()?Icons.clear:Icons.add, color:  !model.getGift().isImageGift() ? Colors.grey:Colors.grey, size: 24.0))),
                              ),
                              (model.getGift().isImageGift())?

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: (model.selectedImage!=null)?
                                AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: new Container(
                                        decoration: new BoxDecoration(
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              alignment: FractionalOffset.center,
                                              image: FileImage(model.selectedImage),
                                            )
                                        ))):


                                Image.network(
                                  model.getGift().getImagePath(SIZE_BIG),
                                ),
                              )

                                  :verticalSpaceTiny,
                                  verticalSpaceMassive












                            ])),
                      )













                    ]
                  ),
                )


              ],



            ),
          )
        )));
  }
}
