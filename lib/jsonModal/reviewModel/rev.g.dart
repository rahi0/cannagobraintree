// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rev.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['success'],
    (json['rev'] as List)
        ?.map((e) => e == null ? null : Rev.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'success': instance.success,
      'rev': instance.rev,
    };

Rev _$RevFromJson(Map<String, dynamic> json) {
  return Rev(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['content'],
    (json['rating'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RevToJson(Rev instance) => <String, dynamic>{
      'rating': instance.rating,
      'content': instance.content,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'],
    json['name'],
    json['img'],
    json['email'],
    json['iphone'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'img': instance.img,
      'name': instance.name,
      'iphone': instance.iphone,
    };
