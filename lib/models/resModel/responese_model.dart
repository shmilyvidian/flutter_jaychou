

import 'package:json_annotation/json_annotation.dart';

part 'responese_model.g.dart';

@JsonSerializable()
class Responese{
  final int code;
  final data;
  final String msg;

  Responese({this.code, this.data, this.msg});

    
  //反序列化
  factory Responese.fromJson(Map<String, dynamic> json) => _$ResponeseFromJson(json);
  
  //序列化
  Map<String, dynamic> toJson() => _$ResponeseToJson(this);
}