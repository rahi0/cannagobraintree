import 'package:json_annotation/json_annotation.dart';
part 'shopModel.g.dart';
@JsonSerializable()
class ShopData{
    dynamic success;
    List<Shop> shop;

  ShopData(this.shop, this.success);

  factory ShopData.fromJson(Map <String, dynamic> json) => 
      _$ShopDataFromJson(json);

}
 
@JsonSerializable()
class Shop{
    dynamic id;
    dynamic userId;
    dynamic name;
    dynamic openingTime;
    dynamic closingTime;
    dynamic address;
    dynamic deliveryFee;
    dynamic lat;
    dynamic lng;
    dynamic license;
    dynamic licenseExpiration;
    dynamic licenseType;
    dynamic growingType;
    dynamic deliver;
    User user;
    Rating avgRating;
    @JsonKey(name: "__meta__")
    Totalrev totalrev; // total number of reviews

    Shop(this.address,this.openingTime, this.closingTime,this.deliveryFee, this.avgRating, this.growingType, this.id, this.lat, this.license, this.licenseExpiration, this.licenseType, this.lng, this.name, this.user, this.userId, this.deliver, this.totalrev);
    factory Shop.fromJson(Map <String, dynamic> json) => 
      _$ShopFromJson(json);

}

@JsonSerializable()
class User{
  dynamic id;
  dynamic email;
  dynamic name;
  dynamic iphone;
  dynamic img;
  User(this.id, this.name, this.email, this.iphone,this.img);
  factory User.fromJson(Map <String, dynamic> json) => 
      _$UserFromJson(json);

}
@JsonSerializable()
class Rating{
  dynamic averageRating;
  Rating(this.averageRating);
  factory Rating.fromJson(Map <String, dynamic> json) => 
      _$RatingFromJson(json);
  
}
@JsonSerializable()
class Totalrev{
  @JsonKey(name: "reviews_count")
  dynamic total;
  Totalrev(this.total);
  factory Totalrev.fromJson(Map <String, dynamic> json) => 
      _$TotalrevFromJson(json);
  
}