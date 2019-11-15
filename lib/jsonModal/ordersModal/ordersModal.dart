import 'package:json_annotation/json_annotation.dart';
part 'ordersModal.g.dart';

@JsonSerializable()
class OrderData{ 
  List<Order> order;
  dynamic isReviewCreated;
  OrderData(this.order,this.isReviewCreated);

  factory OrderData.fromJson(Map <String, dynamic> json) => 
      _$OrderDataFromJson(json);

}
  
@JsonSerializable()
class Order{
    var id;
    var userId;
    var sellerId;
    var driverId;
    var lat;
    var lng;
    var status;
    var price;
    var rating;
    var commend;
    List<Orderdetails> orderdetails;
    Seller seller;
    Driver driver;
    
    Order(this.id, this.userId,this.lat, this.lng, this.price, this.orderdetails, this.rating, this.driverId, this.sellerId, this.status, this.seller, this.commend,
    this.driver);
    factory Order.fromJson(Map <String, dynamic> json) => 
      _$OrderFromJson(json);

}



@JsonSerializable()
class  Seller {
    dynamic id; 
    dynamic userId;
    dynamic name;
    dynamic address;
    dynamic deliveryFee;
    User user;
    Seller(this.id, this.address, this.deliveryFee, this.name, this.user, this.userId);
    factory Seller.fromJson(Map <String, dynamic> json) => 
      _$SellerFromJson(json);
}


@JsonSerializable()
class  Driver {
 
    dynamic id; 
    dynamic userId;
    dynamic lat;
    dynamic lng;
    dynamic license;
    dynamic licenseExpiration;
    dynamic carBrand;
    dynamic carColor;
    dynamic carPlateNumber;
    dynamic carInsurance;
    User user;
    Driver(this.id, this.user, this.userId, this.lat, this.lng, this.license, this.licenseExpiration, this.carBrand, this.carColor, this.carInsurance, this.carPlateNumber);
    factory Driver.fromJson(Map <String, dynamic> json) => 
      _$DriverFromJson(json);
}

@JsonSerializable()
class User{

   dynamic id; 
   dynamic email;
   dynamic name;
   dynamic phone;
   dynamic img;
   dynamic delLat;
   dynamic delLong;
   dynamic delAddress;
   dynamic country;
   dynamic state;
   dynamic birthday;

   User(this.name, this.id, this.email, this.phone,this.birthday, this.country, this.delAddress, this.delLat, this.delLong, this.img, this.state);
   factory User.fromJson(Map <String, dynamic> json) => 
      _$UserFromJson(json);
}


@JsonSerializable()
class Orderdetails{
    var id;
    var orderId;
    var itemId;
    var quantity;
    Item item;
  Orderdetails(this.id, this.quantity, this.item, this.itemId, this.orderId,);
  factory Orderdetails.fromJson(Map <String, dynamic> json) => 
      _$OrderdetailsFromJson(json);

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
  Item(this.id, this.name, this.quantity, this.userId, this.deliveryFee, this.description, this.eta, this.growId,
       this.netPrice, this.price, this.productPrice, this.img);
  factory Item.fromJson(Map <String, dynamic> json) => 
      _$ItemFromJson(json);

} 