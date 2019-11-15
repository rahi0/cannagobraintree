// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordersModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderData _$OrderDataFromJson(Map<String, dynamic> json) {
  return OrderData(
    (json['order'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['isReviewCreated'],
  );
}

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'order': instance.order,
      'isReviewCreated': instance.isReviewCreated,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'],
    json['userId'],
    json['lat'],
    json['lng'],
    json['price'],
    (json['orderdetails'] as List)
        ?.map((e) =>
            e == null ? null : Orderdetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['rating'],
    json['driverId'],
    json['sellerId'],
    json['status'],
    json['seller'] == null
        ? null
        : Seller.fromJson(json['seller'] as Map<String, dynamic>),
    json['commend'],
    json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'sellerId': instance.sellerId,
      'driverId': instance.driverId,
      'lat': instance.lat,
      'lng': instance.lng,
      'status': instance.status,
      'price': instance.price,
      'rating': instance.rating,
      'commend': instance.commend,
      'orderdetails': instance.orderdetails,
      'seller': instance.seller,
      'driver': instance.driver,
    };

Seller _$SellerFromJson(Map<String, dynamic> json) {
  return Seller(
    json['id'],
    json['address'],
    json['deliveryFee'],
    json['name'],
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['userId'],
  );
}

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'address': instance.address,
      'deliveryFee': instance.deliveryFee,
      'user': instance.user,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
    json['id'],
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['userId'],
    json['lat'],
    json['lng'],
    json['license'],
    json['licenseExpiration'],
    json['carBrand'],
    json['carColor'],
    json['carInsurance'],
    json['carPlateNumber'],
  );
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'lat': instance.lat,
      'lng': instance.lng,
      'license': instance.license,
      'licenseExpiration': instance.licenseExpiration,
      'carBrand': instance.carBrand,
      'carColor': instance.carColor,
      'carPlateNumber': instance.carPlateNumber,
      'carInsurance': instance.carInsurance,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'],
    json['id'],
    json['email'],
    json['phone'],
    json['birthday'],
    json['country'],
    json['delAddress'],
    json['delLat'],
    json['delLong'],
    json['img'],
    json['state'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'img': instance.img,
      'delLat': instance.delLat,
      'delLong': instance.delLong,
      'delAddress': instance.delAddress,
      'country': instance.country,
      'state': instance.state,
      'birthday': instance.birthday,
    };

Orderdetails _$OrderdetailsFromJson(Map<String, dynamic> json) {
  return Orderdetails(
    json['id'],
    json['quantity'],
    json['item'] == null
        ? null
        : Item.fromJson(json['item'] as Map<String, dynamic>),
    json['itemId'],
    json['orderId'],
  );
}

Map<String, dynamic> _$OrderdetailsToJson(Orderdetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'itemId': instance.itemId,
      'quantity': instance.quantity,
      'item': instance.item,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['id'],
    json['name'],
    json['quantity'],
    json['userId'],
    json['deliveryFee'],
    json['description'],
    json['eta'],
    json['growId'],
    json['netPrice'],
    json['price'],
    json['productPrice'],
    json['img'],
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'growId': instance.growId,
      'name': instance.name,
      'deliveryFee': instance.deliveryFee,
      'price': instance.price,
      'img': instance.img,
      'productPrice': instance.productPrice,
      'netPrice': instance.netPrice,
      'eta': instance.eta,
      'quantity': instance.quantity,
      'description': instance.description,
    };
