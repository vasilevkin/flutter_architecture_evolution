// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    company: json['company'] as String,
    url: json['url'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'company': instance.company,
      'url': instance.url,
      'text': instance.text,
    };
