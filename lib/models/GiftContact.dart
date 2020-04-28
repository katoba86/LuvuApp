class GiftContact{
  String name;
  String id;
  String phones;


  GiftContact({
    this.id,
    this.name,
    this.phones,
  });


  Map<String, dynamic> toJson() => <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'phones':this.phones
    };




}