// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responese_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Responese _$ResponeseFromJson(Map<String, dynamic> json) {
  return Responese(
      code: json['code'] as int,
      data: json['data'],
      msg: json['msg'] as String);
}

Map<String, dynamic> _$ResponeseToJson(Responese instance) => <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg
    };
