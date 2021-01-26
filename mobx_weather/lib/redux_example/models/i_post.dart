import 'package:json_annotation/json_annotation.dart';

part 'i_post.g.dart';

@JsonSerializable()
class Ipost {
  int id;
  int userId;
  String title;
  String body;

  Ipost(this.id, this.userId, this.title, this.body);

  static List<Ipost> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Ipost>()
        : json.map((value) => Ipost.fromJson(value)).toList();
  }

  factory Ipost.fromJson(Map<String, dynamic> json) => _$IpostFromJson(json);

  Map<String, dynamic> toJson() => _$IpostToJson(this);
}
