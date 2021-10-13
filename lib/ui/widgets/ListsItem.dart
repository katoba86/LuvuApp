import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/Lists.dart';
import 'package:luvutest/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/ui/shared/theme.dart';

class ListsItem extends StatelessWidget {
  final Lists list;
  final Function onDeleteItem;
  final Function onEditItem;



  const ListsItem({
    Key key,
    this.list,
    this.onDeleteItem,
    this.onEditItem,
  }) : super(key: key);

  Widget getGiftImage(){

      return CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(list.getShortName()),
        foregroundColor: Colors.white,
      );



  }

  Widget get2Lines(){
    return ListTile(
      leading: getGiftImage(),
      //  title: Text(gift.name,style: TextStyle(color: Colors.white),),
      title: Text(list.name),
      trailing: Icon(Icons.chevron_right),
    );
  }




  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,

      child: Slidable(
        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          decoration: BoxDecoration(
            //color: Theme.of(context).primaryColor,
            color: Color.fromARGB(200, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),

          child: get2Lines(),
        ),
        actions: <Widget>[

          IconSlideAction(
            caption: 'Teilen',
            color: LuvuTheme.getShade().shade400,
            icon: Icons.share,

            onTap: () => _showSnackBar('Share'),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Ändern',
            color: Colors.black45,
            icon: Icons.edit,
            onTap: (){
              if (onEditItem != null) {
                onEditItem();
              }
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: (){
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      )




      ,
    );
  }

  _showSnackBar(String s) {
    print(s);

  }
}
