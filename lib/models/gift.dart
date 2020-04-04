
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gift.g.dart';

@JsonSerializable()
class Gift{
  int id;
  String name;
  String description;

  String theme;
  String get_up_to;
  String link = "http://localhost";
  String icon = "add";
  int referenceToGroup;

  Gift({
    @required this.id,
    @required this.name,
    this.description,
    this.theme,
    this.get_up_to,
    this.link,
    this.icon,
    this.referenceToGroup
  });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'theme': theme,
      'get_up_to':get_up_to,
      'link':link,
      'icon':icon,
      'reference_to_group':referenceToGroup
    };
  }

  static Gift fromMap(Map<String, dynamic> map, int id) {
    if (map == null) return null;

    return Gift(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      theme: map['theme'],
        get_up_to: map['get_up_to'],
      link: map['link'],
      icon: map['icon'],
        referenceToGroup: map['reference_to_group']
    );
  }




  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);
  Map<String, dynamic> toJson() => _$GiftToJson(this);

}