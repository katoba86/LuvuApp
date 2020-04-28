import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luvutest/ui/shared/theme.dart';

class Invite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    const TextStyle textStyleWhite = TextStyle(color: Colors.white);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Slidable(

        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        child: Container(

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),topRight: Radius.circular(24)),

          ),

          child: ListTile(
            contentPadding: EdgeInsets.only(right: 8,left:8),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('SW'),
              foregroundColor: Theme.of(context).primaryColor,
            ),
            title: Text('Silvia Willam',style: textStyleWhite,),
            subtitle: Text('für Liste "Weihnachten 2020"',style: TextStyle(color: Color.fromARGB(180, 255, 255, 255)),),
            trailing:InkWell(
              onTap: ()=>{},
                        child:
                        Container(
                            child:Text("Senden",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16,letterSpacing: 1.3),)
                        ),

    )

          ),
        ),
        secondaryActions: <Widget>[



      IconSlideAction(
      caption: 'Löschen',
        color: Colors.transparent,
        icon: Icons.delete_forever,
foregroundColor: Colors.blueGrey,
        onTap: () =>{},
      ),
        ],
      )




      ,
    );
  }
}