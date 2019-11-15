import 'package:json_annotation/json_annotation.dart';

part 'GetAddressModel.g.dart';

@JsonSerializable()
class GetAddressModel {
  List<Results> results;

  GetAddressModel(this.results);

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      _$GetAddressModelFromJson(json);
}

@JsonSerializable()
class Results {
  dynamic formatted_address;

  Results(this.formatted_address);

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}