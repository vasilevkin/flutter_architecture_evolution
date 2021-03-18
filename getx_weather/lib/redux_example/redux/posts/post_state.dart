import 'package:flutter/material.dart';
import 'package:getx_weather/redux_example/models/i_post.dart';

@immutable
class PostsState {
  final bool isError;
  final bool isLoading;
  final List<Ipost> posts;

  PostsState({this.isError, this.isLoading, this.posts});

  factory PostsState.initial() => PostsState(
        isError: false,
        isLoading: false,
        posts: const [],
      );

  PostsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<Ipost> posts,
  }) {
    return PostsState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
    );
  }
}
