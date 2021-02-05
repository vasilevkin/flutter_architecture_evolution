import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/data/data_models.dart';

class NetworkService {
  List<User> users = [];
  List<Post> posts = [];

  Future getData(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      users = (data['data'] as List).map((json) {
        return User.fromJson(json);
      }).toList();
      return users;
    } else {
      print('Error in url users');
    }
  }

  Future getPosts(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      posts = (data as List).map((json) {
        return Post.fromJson(json);
      }).toList();
      return posts;
    } else {
      print('Error in url posts');
    }
  }
}
