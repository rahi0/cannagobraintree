// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notiModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotiModel _$NotiModelFromJson(Map<String, dynamic> json) {
  return NotiModel(
    json['success'] as bool,
    (json['noti'] as List)
        ?.map(
            (e) => e == null ? null : Noti.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotiModelToJson(NotiModel instance) => <String, dynamic>{
      'success': instance.success,
      'noti': instance.noti,
    };

Noti _$NotiFromJson(Map<String, dynamic> json) {
  return Noti(
    json['id'],
    json['seen'],
    json['msg'],
    json['title'],
    json['created_at'],
  );
}

Map<String, dynamic> _$NotiToJson(Noti instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'msg': instance.msg,
      'seen': instance.seen,
      'created_at': instance.created,
    };
