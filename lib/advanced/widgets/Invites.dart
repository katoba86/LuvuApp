import 'package:flutter/material.dart';

import '../AppColors.dart';



class Invites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 9,
      separatorBuilder: (context, index) => Divider(),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Invite(
          title: "Test",
          time: "15 May 2019",
          thumbnail: Image.asset("assets/images/c1.png"),
        );
      },
    );
  }
}


class Invite extends StatelessWidget {
  const Invite({
    Key key,
    @required this.title,
    @required this.time,
    @required this.thumbnail,
  }) : super(key: key);

  final Image thumbnail;
  final String time;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 36),
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1.6,
              child: thumbnail,
            ),
          ),
        ],
      ),
    );
  }
}