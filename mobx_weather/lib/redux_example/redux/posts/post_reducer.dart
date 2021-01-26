import 'package:mobx_weather/redux_example/redux/posts/post_actions.dart';
import 'package:mobx_weather/redux_example/redux/posts/post_state.dart';

postsReducer(PostsState prevState, SetPostsStateAction action) {
  final payload = action.postsState;

  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    posts: payload.posts,
  );
}
