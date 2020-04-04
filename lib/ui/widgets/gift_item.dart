import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luvutest/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/ui/shared/theme.dart';

class GiftItem extends StatelessWidget {
  final Gift post;
  final Function onDeleteItem;
  final Function onEditItem;



  const GiftItem({
    Key key,
    this.post,
    this.onDeleteItem,
    this.onEditItem,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Slidable(
        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink,
              child: Icon(Icons.card_giftcard),
              foregroundColor: Colors.white,
            ),
            title: Text(post.name),
            subtitle: Text(post.description),
          ),
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


 /*   return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(post.name),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(post.description),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteItem != null) {
                onDeleteItem();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    ); */
  }

  _showSnackBar(String s) {
    print(s);

  }
}
