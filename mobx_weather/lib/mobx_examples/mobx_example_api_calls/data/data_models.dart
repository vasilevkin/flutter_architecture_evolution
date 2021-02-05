import 'package:json_annotation/json_annotation.dart';

part 'data_models.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  String email, avatar;

  // int id;

  @JsonKey(name: 'id')
  int followers;

  String get name => '$firstName $lastName';

  User(
      this.firstName,
      this.lastName,
      this.email,
      this.avatar,
      // this.id,
      this.followers);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Post {
  final int id;
  final String title, body;

  Post({this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
