// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'i_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ipost _$IpostFromJson(Map<String, dynamic> json) {
  return Ipost(
    json['id'] as int,
    json['userId'] as int,
    json['title'] as String,
    json['body'] as String,
  );
}

Map<String, dynamic> _$IpostToJson(Ipost instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
    };
