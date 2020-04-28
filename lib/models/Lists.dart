import 'package:flutter/foundation.dart';

class Lists{
  int id;
  String name;
  bool alluserscan_post;
  bool all_users_can_invite;
  String created_at;
  String updated_at;


  Lists({
    @required this.id,
    @required this.name,
    this.alluserscan_post,
    this.all_users_can_invite,
    this.created_at,
    this.updated_at
  });


  factory Lists.fromJson(Map<String, dynamic> json) => _$ListsFromJson(json);
  Map<String, dynamic> toJson() => _$ListsToJson(this);

  String getShortName() {

    String str =  this.name.trim().split(" ").map((word) => word.substring(0,1).toUpperCase()).toList().join();
    return (str.length>=2)?str.substring(0,2):str.substring(0,1);

  }





}

Lists _$ListsFromJson(Map<String, dynamic> json) {
  return Lists(
    id: json['id'] as int,
    name: json['name'] as String,
    alluserscan_post: (json['alluserscan_post']==0)?false:true,
    all_users_can_invite: (json['all_users_can_invite']==0)?false:true,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$ListsToJson(Lists instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'alluserscan_post': instance.alluserscan_post,
  'all_users_can_invite': instance.all_users_can_invite,
  'created_at': instance.created_at,
  'updated_at': instance.updated_at,
};
