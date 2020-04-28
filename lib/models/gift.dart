import 'package:flutter/foundation.dart';
import 'package:luvutest/constants/config.dart';
import 'package:luvutest/models/GiftContact.dart';


class Gift{

  int id;
  bool hasImage;
  String name;
  int userId;
  String createdAt;
  GiftContact toContact;
  int reference_to_group;


  Gift({
    @required this.id,
    @required this.name,
    this.toContact,
    this.hasImage,
    this.userId,
    this.createdAt,
    this.reference_to_group
  });

  factory Gift.fromJson(Map<String, dynamic> data) {

    GiftContact go;

    if(data.containsKey("toContact") && data["toContact"]!=null && data["toContact"]["name"]!="null") {
          go = new GiftContact(id: data["toContact"]["id"].toString(),name: data["toContact"]["name"].toString());
    }

    return Gift(
        id: data['id'] as int,
        name: data['name'] as String,
        toContact: (go!=null)?go:null,
        hasImage: (data.containsKey('withImage')),
        createdAt: data["created_at"],
        reference_to_group: data["reference_to_group"],
        userId:data["user_id"]
    );
  }

  Map<String, dynamic> _$GiftToJson(Gift instance){

    return <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'reference_to_group': instance.reference_to_group,
    'toContact':(instance.toContact!=null)?toContact.toJson():null
    };

  }

  bool isImageGift(){
    return (this.hasImage!=null && true==this.hasImage);
  }

  Map<String, dynamic> toJson() => _$GiftToJson(this);

  String getImagePath(int size) {
        return "$IMAGE_SERVER/${this.userId}/${size}_${this.id}.jpg";
  }



  String getShortName() {
    String str=(this.toContact!=null)?this.toContact.name:this.name;
       str =  str.trim().split(" ").map((word) => word.substring(0,1).toUpperCase()).toList().join();
     return (str.length>=2)?str.substring(0,2):str.substring(0,1);

  }

}