import 'package:json_annotation/json_annotation.dart';
part 'BraintreeTokenModel.g.dart';

@JsonSerializable()
class BraintreeTokenModel{ 

  dynamic token;
 
  BraintreeTokenModel(this.token);

  factory BraintreeTokenModel.fromJson(Map <String, dynamic> json) => 
      _$BraintreeTokenModelFromJson(json);

}
 