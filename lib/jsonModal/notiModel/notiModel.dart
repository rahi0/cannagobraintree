import 'package:json_annotation/json_annotation.dart';
part 'notiModel.g.dart';
@JsonSerializable()
class NotiModel {
  bool success; 
  final List<Noti> noti;
  NotiModel(this.success, this.noti);
  factory NotiModel.fromJson(Map<String, dynamic> json) =>
      _$NotiModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotiModelToJson(this);

}

@JsonSerializable()
class Noti{
    dynamic id; 
    dynamic title; 
    dynamic msg; 
    dynamic seen; 
    @JsonKey(name: "created_at")
    dynamic created;
   
    Noti(this.id, this.seen, this.msg, this.title, this.created);
    factory Noti.fromJson(Map<String, dynamic> json) =>
      _$NotiFromJson(json);
  Map<String, dynamic> toJson() => _$NotiToJson(this);

}