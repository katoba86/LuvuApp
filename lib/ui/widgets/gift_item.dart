import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:luvutest/ui/shared/theme.dart';

class GiftItem extends StatelessWidget {
  final Gift gift;
  final Function onDeleteItem;
  final Function onEditItem;



  const GiftItem({
    Key key,
    this.gift,
    this.onDeleteItem,
    this.onEditItem,
  }) : super(key: key);

  Widget getGiftImage(){
    if(this.gift.isImageGift()) {
      return CachedNetworkImage(
        imageUrl: this.gift.getImagePath(SIZE_MEDIUM),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context,imageProvider){

          return Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          );
        },
      );

    }else{
      return CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(gift.getShortName()),
        foregroundColor: Colors.white,
      );
    }


  }

  Widget get2Lines(){
    return ListTile(
      leading: getGiftImage(),
      //  title: Text(gift.name,style: TextStyle(color: Colors.white),),
      title: Text(gift.name),
      trailing: Icon(Icons.chevron_right),
    );
  }

  Widget get3Lines(){
    return ListTile(
      leading: getGiftImage(),
      //  title: Text(gift.name,style: TextStyle(color: Colors.white),),
      title: Text(gift.name),
      subtitle: Text(gift.toContact.name),
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

          child: (gift.toContact==null || gift.toContact.name==null )?get2Lines():get3Lines(),
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
