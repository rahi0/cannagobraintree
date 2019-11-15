import 'package:json_annotation/json_annotation.dart';
part 'GetItemReview.g.dart';

@JsonSerializable()
class GetItemReview{ 
 
  dynamic isItemReviewGiven;

  GetItemReview(this.isItemReviewGiven);
 

  factory GetItemReview.fromJson(Map <String, dynamic> json) => 
      _$GetItemReviewFromJson(json);

}