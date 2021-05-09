import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class Ad {
  String company;
  String url;
  String text;

  Ad({this.company, this.url, this.text});

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);
}
