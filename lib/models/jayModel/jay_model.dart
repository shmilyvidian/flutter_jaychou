
import 'package:json_annotation/json_annotation.dart';

part 'jay_model.g.dart';

@JsonSerializable()
class JayList{
  final String id;
  final String name;
  final String time;
  final String imgurl;
  final String desc;
  JayList({this.id, this.name,this.time, this.imgurl,this.desc});

    
  //反序列化
  factory JayList.fromJson(Map<String, dynamic> json) => _$JayListFromJson(json);
  
  //序列化
  Map<String, dynamic> toJson() => _$JayListToJson(this);
}