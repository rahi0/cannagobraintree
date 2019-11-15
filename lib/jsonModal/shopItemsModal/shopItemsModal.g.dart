// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopItemsModal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopItems _$ShopItemsFromJson(Map<String, dynamic> json) {
  return ShopItems(
    (json['allItems'] as List)
        ?.map((e) =>
            e == null ? null : AllItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'],
  );
}

Map<String, dynamic> _$ShopItemsToJson(ShopItems instance) => <String, dynamic>{
      'success': instance.success,
      'allItems': instance.allItems,
    };

AllItems _$AllItemsFromJson(Map<String, dynamic> json) {
  return AllItems(
    json['id'],
    json['growId'],
    json['name'],
    json['price'],
    json['img'],
    json['description'],
    json['eta'],
    json['quantity'],
    json['avgRating'] == null
        ? null
        : Rating.fromJson(json['avgRating'] as Map<String, dynamic>),
    json['__meta__'] == null
        ? null
        : Totalrev.fromJson(json['__meta__'] as Map<String, dynamic>),
  )..store = json['store'] == null
      ? null
      : Store.fromJson(json['store'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AllItemsToJson(AllItems instance) => <String, dynamic>{
      'id': instance.id,
      'growId': instance.growId,
      'name': instance.name,
      'price': instance.price,
      'img': instance.img,
      'description': instance.description,
      'eta': instance.eta,
      'quantity': instance.quantity,
      'store': instance.store,
      'avgRating': instance.avgRating,
      '__meta__': instance.totalrev,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return Rating(
    json['averageRating'],
  );
}

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'averageRating': instance.averageRating,
    };

Totalrev _$TotalrevFromJson(Map<String, dynamic> json) {
  return Totalrev(
    json['reviews_count'],
  );
}

Map<String, dynamic> _$TotalrevToJson(Totalrev instance) => <String, dynamic>{
      'reviews_count': instance.total,
    };

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    json['id'],
    json['userId'],
    json['name'],
    json['address'],
    json['deliveryFee'],
    json['lat'],
    json['lng'],
    json['license'],
    json['licenseExpiration'],
    json['licenseType'],
    json['deliver'],
    json['growingType'],
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'address': instance.address,
      'deliveryFee': instance.deliveryFee,
      'lat': instance.lat,
      'lng': instance.lng,
      'license': instance.license,
      'licenseExpiration': instance.licenseExpiration,
      'licenseType': instance.licenseType,
      'growingType': instance.growingType,
      'deliver': instance.deliver,
    };
