import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_weather/redux_example/models/i_post.dart';
import 'package:redux_weather/redux_example/redux/posts/post_actions.dart';
import 'package:redux_weather/redux_example/redux/store.dart';

void exampleMain() async {
  await Redux.init();

  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  static const String title = 'Redux demo example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: StoreProvider<AppState>(
        store: Redux.store,
        child: ExampleHomePage(
          title: title,
        ),
      ),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  final String title;

  const ExampleHomePage({Key key, this.title}) : super(key: key);

  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  void _onFetchPostsPressed() {
    Redux.store.dispatch(fetchPostsAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: FlatButton(
        //   onPressed: () =>
        //   SystemNavigator.pop(),
        //       // Navigator.pop(context),
        //   child: Icon(Icons.arrow_back),
        // ),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: _onFetchPostsPressed,
            child: Text('Fetch posts'),
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.postsState.isLoading,
            builder: (context, isLoaging) {
              return (isLoaging == true)
                  ? CircularProgressIndicator()
                  : SizedBox.shrink();
            },
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.postsState.isError,
            builder: (context, isError) {
              return isError
                  ? Text('Failed to fetch posts')
                  : SizedBox.shrink();
            },
          ),
          Expanded(
            child: StoreConnector<AppState, List<Ipost>>(
              distinct: true,
              converter: (store) => store.state.postsState.posts,
              builder: (context, posts) {
                return ListView(
                  children: _buildPosts(posts),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPosts(List<Ipost> posts) {
    return posts
        .map(
          (post) => ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            key: Key(post.id.toString()),
          ),
        )
        .toList();
  }
}
