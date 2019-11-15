// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurtData _$CurtDataFromJson(Map<String, dynamic> json) {
  return CurtData(
    (json['curt'] as List)
        ?.map(
            (e) => e == null ? null : Curt.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CurtDataToJson(CurtData instance) => <String, dynamic>{
      'curt': instance.curt,
    };

Curt _$CurtFromJson(Map<String, dynamic> json) {
  return Curt(
    json['id'],
    json['userId'],
    json['item'] == null
        ? null
        : Item.fromJson(json['item'] as Map<String, dynamic>),
    json['itemId'],
    json['quantity'],
  );
}

Map<String, dynamic> _$CurtToJson(Curt instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
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
    json['img'],
    json['description'],
    json['eta'],
    json['growId'],
    json['netPrice'],
    json['price'],
    json['productPrice'],
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
