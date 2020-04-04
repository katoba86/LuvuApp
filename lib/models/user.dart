import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';


@JsonSerializable()
class User{


  String id;
  String name;
  String email;
  String token;

  User({this.id, this.name, this.email,this.token=""});


  User.fromData(Map<String, dynamic> data)
    : id = data['id'],
    name = data['name'],
    email = data['email'],
    token = "";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}