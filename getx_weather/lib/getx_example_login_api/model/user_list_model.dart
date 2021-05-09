import 'package:getx_weather/getx_example_login_api/model/ad.dart';
import 'package:getx_weather/getx_example_login_api/model/data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_list_model.g.dart';

@JsonSerializable()
class UserListModel {
  int page;

  @JsonKey(name: 'per_page')
  int perPage;

  int total;

  @JsonKey(name: 'total_pages')
  int totalPages;

  List<Data> data;
  Ad ad;

  UserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserListModelToJson(this);
}
