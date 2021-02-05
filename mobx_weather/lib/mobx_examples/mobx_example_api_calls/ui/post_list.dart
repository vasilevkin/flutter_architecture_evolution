import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/data/data_models.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/store/post_store.dart';

class PostList extends StatelessWidget {
  final PostStore store = PostStore();

  PostList() {
    store.getThePosts();
  }

  @override
  Widget build(BuildContext context) {
    final future = store.postsListFuture;

    return Observer(
      builder: (_) {
        switch (future.status) {
          case FutureStatus.pending:
            return Center(child: CircularProgressIndicator());

          case FutureStatus.rejected:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ErrorMessages.exampleApiCallsLoadError,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: _refresh,
                    child: const Text(Constants.exampleApiCallsRetry),
                  ),
                ],
              ),
            );

          case FutureStatus.fulfilled:
            final List<Post> posts = future.result;

            print('MobX example api calls:: posts= $posts');

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ExpansionTile(
                    title: Text(
                      post.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Text(post.body),
                    ],
                  );
                },
              ),
            );

            break;

          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future _refresh() => store.fetchPosts();
}
