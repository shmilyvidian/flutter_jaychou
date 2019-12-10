import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User{
  final String username;
  final String password;

  User({this.username, this.password});

    
  //反序列化
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  //序列化
  Map<String, dynamic> toJson() => _$UserToJson(this);
};