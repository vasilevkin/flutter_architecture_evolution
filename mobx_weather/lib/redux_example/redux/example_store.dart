import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:mobx_weather/redux_example/redux/posts/post_actions.dart';
import 'package:mobx_weather/redux_example/redux/posts/post_reducer.dart';
import 'package:mobx_weather/redux_example/redux/posts/post_state.dart';

ExampleAppState exampleAppReducer(ExampleAppState state, dynamic action) {
  if (action is SetPostsStateAction) {
    final nextPostState = postsReducer(state.postsState, action);

    return state.copyWith(postsState: nextPostState);
  }

  return state;
}

@immutable
class ExampleAppState {
  final PostsState postsState;

  ExampleAppState({@required this.postsState});

  ExampleAppState copyWith({PostsState postsState}) {
    return ExampleAppState(postsState: postsState ?? this.postsState);
  }
}

class ExampleRedux {
  static Store<ExampleAppState> _store;

  static Store<ExampleAppState> get store {
    if (_store == null) {
      throw Exception("Store is not initialized.");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final postsStateInitial = PostsState.initial();

    _store = Store<ExampleAppState>(
      exampleAppReducer,
      middleware: [thunkMiddleware],
      initialState: ExampleAppState(postsState: postsStateInitial),
    );
  }
}
