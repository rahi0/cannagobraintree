// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetAddressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressModel _$GetAddressModelFromJson(Map<String, dynamic> json) {
  return GetAddressModel(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAddressModelToJson(GetAddressModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    json['formatted_address'],
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'formatted_address': instance.formatted_address,
    };
