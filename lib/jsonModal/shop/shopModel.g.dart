// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopData _$ShopDataFromJson(Map<String, dynamic> json) {
  return ShopData(
    (json['shop'] as List)
        ?.map(
            (e) => e == null ? null : Shop.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'],
  );
}

Map<String, dynamic> _$ShopDataToJson(ShopData instance) => <String, dynamic>{
      'success': instance.success,
      'shop': instance.shop,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop(
    json['address'],
    json['openingTime'],
    json['closingTime'],
    json['deliveryFee'],
    json['avgRating'] == null
        ? null
        : Rating.fromJson(json['avgRating'] as Map<String, dynamic>),
    json['growingType'],
    json['id'],
    json['lat'],
    json['license'],
    json['licenseExpiration'],
    json['licenseType'],
    json['lng'],
    json['name'],
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['userId'],
    json['deliver'],
    json['__meta__'] == null
        ? null
        : Totalrev.fromJson(json['__meta__'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
      'address': instance.address,
      'deliveryFee': instance.deliveryFee,
      'lat': instance.lat,
      'lng': instance.lng,
      'license': instance.license,
      'licenseExpiration': instance.licenseExpiration,
      'licenseType': instance.licenseType,
      'growingType': instance.growingType,
      'deliver': instance.deliver,
      'user': instance.user,
      'avgRating': instance.avgRating,
      '__meta__': instance.totalrev,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'],
    json['name'],
    json['email'],
    json['iphone'],
    json['img'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'iphone': instance.iphone,
      'img': instance.img,
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
