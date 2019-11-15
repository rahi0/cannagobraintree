import 'package:json_annotation/json_annotation.dart';
part 'shopItemsModal.g.dart';

@JsonSerializable()
class ShopItems {
  dynamic success;
  List<AllItems> allItems;

  ShopItems(this.allItems, this.success);

  factory ShopItems.fromJson(Map<String, dynamic> json) =>
      _$ShopItemsFromJson(json);
}

@JsonSerializable()
class AllItems {
  var id;
  var growId;
  var name;
  var price;
  var img;
  var description;
  var eta;
  var quantity;
  Store store;

  Rating avgRating;
  @JsonKey(name: "__meta__")
  Totalrev totalrev; // total number of reviews

  AllItems(this.id, this.growId,this.name, this.price, this.img,this.description, this.eta,
      this.quantity, this.avgRating, this.totalrev);

  factory AllItems.fromJson(Map<String, dynamic> json) =>
      _$AllItemsFromJson(json);
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

@JsonSerializable()
class Store{
    dynamic id;
    dynamic userId;
    dynamic name;
    dynamic address;
    dynamic deliveryFee;
    dynamic lat;
    dynamic lng;
    dynamic license;
    dynamic licenseExpiration;
    dynamic licenseType;
    dynamic growingType;
    dynamic deliver;
  Store(this.id, this.userId, this.name, this.address, this.deliveryFee, this.lat, this.lng, this.license, this.licenseExpiration, this.licenseType, this.deliver, this.growingType);
  factory Store.fromJson(Map <String, dynamic> json) => 
      _$StoreFromJson(json);
  
}