import 'package:json_annotation/json_annotation.dart';

part 'SearchAddressModel.g.dart';

@JsonSerializable()
class SearchAddressModel {
  List<Results> results;
  dynamic status;

  SearchAddressModel(this.results, this.status);

  factory SearchAddressModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAddressModelFromJson(json);
}

@JsonSerializable()
class Results {

  Geometry geometry;

  Results(this.geometry);

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}

@JsonSerializable()
class Geometry {

  LocationFind location;

  Geometry(this.location);

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@JsonSerializable()
class LocationFind {

  dynamic lat;
  dynamic lng;

  LocationFind(this.lat, this.lng);

  factory LocationFind.fromJson(Map<String, dynamic> json) =>
      _$LocationFindFromJson(json);
}