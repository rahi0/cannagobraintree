// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchAddressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchAddressModel _$SearchAddressModelFromJson(Map<String, dynamic> json) {
  return SearchAddressModel(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Results.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['status'],
  );
}

Map<String, dynamic> _$SearchAddressModelToJson(SearchAddressModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'status': instance.status,
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
    json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'geometry': instance.geometry,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry(
    json['location'] == null
        ? null
        : LocationFind.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

LocationFind _$LocationFindFromJson(Map<String, dynamic> json) {
  return LocationFind(
    json['lat'],
    json['lng'],
  );
}

Map<String, dynamic> _$LocationFindToJson(LocationFind instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
