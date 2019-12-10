// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jay_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JayList _$JayListFromJson(Map<String, dynamic> json) {
  return JayList(
      id: json['id'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      imgurl: json['imgurl'] as String,
      desc: json['desc'] as String);
}

Map<String, dynamic> _$JayListToJson(JayList instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time': instance.time,
      'imgurl': instance.imgurl,
      'desc': instance.desc
    };
