import 'package:json_annotation/json_annotation.dart';
part 'GetDriverReview.g.dart';

@JsonSerializable()
class GetDriverReview{ 
 
  dynamic isDriverReviewGiven;

  GetDriverReview(this.isDriverReviewGiven);
 

  factory GetDriverReview.fromJson(Map <String, dynamic> json) => 
      _$GetDriverReviewFromJson(json);

}