// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gift _$GiftFromJson(Map<String, dynamic> json) {
  return Gift(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    theme: json['theme'] as String,
    get_up_to: json['get_up_to'] as String,
    link: json['link'] as String,
    icon: json['icon'] as String,
    referenceToGroup: json['referenceToGroup'] as int,
  );
}

Map<String, dynamic> _$GiftToJson(Gift instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'theme': instance.theme,
      'get_up_to': instance.get_up_to,
      'link': instance.link,
      'icon': instance.icon,
      'referenceToGroup': instance.referenceToGroup,
    };
