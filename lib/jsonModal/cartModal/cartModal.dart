import 'package:json_annotation/json_annotation.dart';
part 'cartModal.g.dart';

@JsonSerializable()
class CurtData{ 
    List<Curt> curt;

  CurtData(this.curt);

  factory CurtData.fromJson(Map <String, dynamic> json) => 
      _$CurtDataFromJson(json);

}
 
@JsonSerializable()
class Curt{
    var id;
    var userId;
    var itemId;
    var quantity;
    Item item; 

    Curt(this.id, this.userId, this.item, this.itemId, this.quantity);
    factory Curt.fromJson(Map <String, dynamic> json) => 
      _$CurtFromJson(json);

}



@JsonSerializable()
class Item{
    var id;
    var userId;
    var growId;
    var name;
    var deliveryFee;
    var price;
    var img;
    var productPrice;
    var netPrice;
    var eta;
    var quantity;
    var description;
  Item(this.id, this.name, this.quantity, this.userId, this.deliveryFee,this.img, this.description, this.eta, this.growId,
       this.netPrice, this.price, this.productPrice);
  factory Item.fromJson(Map <String, dynamic> json) => 
      _$ItemFromJson(json);

}