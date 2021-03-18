import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:getx_weather/redux_example/models/i_post.dart';
import 'package:getx_weather/redux_example/redux/example_store.dart';
import 'package:getx_weather/redux_example/redux/posts/post_state.dart';

@immutable
class SetPostsStateAction {
  final PostsState postsState;

  SetPostsStateAction(this.postsState);
}

Future<void> fetchPostsAction(Store<ExampleAppState> store) async {
  store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));

  try {
    final response =
        await http.get('http://jsonplaceholder.typicode.com/posts');

    assert(response.statusCode == 200);

    final jsonData = json.decode(response.body);

    store.dispatch(
      SetPostsStateAction(
        PostsState(
          isLoading: false,
          posts: Ipost.listFromJson(jsonData),
        ),
      ),
    );
  } catch (error) {
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false)));
  }
}
