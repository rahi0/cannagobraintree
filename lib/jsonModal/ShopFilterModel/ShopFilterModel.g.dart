// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShopFilterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopFilterModel _$ShopFilterModelFromJson(Map<String, dynamic> json) {
  return ShopFilterModel(
    (json['allShops'] as List)
        ?.map((e) =>
            e == null ? null : AllShops.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'],
  );
}

Map<String, dynamic> _$ShopFilterModelToJson(ShopFilterModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'allShops': instance.allShops,
    };

AllShops _$AllShopsFromJson(Map<String, dynamic> json) {
  return AllShops(
    json['address'],
    json['deliveryFee'],
    json['openingTime'],
    json['closingTime'],
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

Map<String, dynamic> _$AllShopsToJson(AllShops instance) => <String, dynamic>{
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
