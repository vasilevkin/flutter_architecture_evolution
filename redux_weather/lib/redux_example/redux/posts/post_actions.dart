import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:redux_weather/redux_example/models/i_post.dart';
import 'package:redux_weather/redux_example/redux/posts/post_state.dart';

import 'package:redux/redux.dart';

import 'package:meta/meta.dart';
import 'package:redux_weather/redux_example/redux/example_store.dart';

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
