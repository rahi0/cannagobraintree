import 'package:json_annotation/json_annotation.dart';
part 'rev.g.dart';
@JsonSerializable()

class Review{
  dynamic success;
  List<Rev> rev;
  Review(this.success, this.rev);
  factory Review.fromJson(Map <String, dynamic> json) => 
      _$ReviewFromJson(json);
}
@JsonSerializable()
class Rev{
   double rating; 
   dynamic content; 
   User user; 
   Rev(this.user, this.content, this.rating);
   factory Rev.fromJson(Map <String, dynamic> json) => 
      _$RevFromJson(json);

}
@JsonSerializable()
class User{
  dynamic id;
  dynamic email;
  dynamic img;
  dynamic name;
  dynamic iphone;
  User(this.id, this.name,this.img, this.email, this.iphone);
  factory User.fromJson(Map <String, dynamic> json) => 
      _$UserFromJson(json);
}