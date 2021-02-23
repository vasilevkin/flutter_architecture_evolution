import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_hacker_news/hacker_news_store.dart';

class FeedItemsView extends StatelessWidget {
  final HackerNewsStore store;
  final FeedType type;

  const FeedItemsView(this.store, this.type);

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          final future = type == FeedType.latest
              ? store.latestItemsFuture
              : store.topItemsFuture;

          switch (future.status) {
            case FutureStatus.pending:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text(Constants.exampleHackerNewsLoading),
                ],
              );

            case FutureStatus.rejected:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    ErrorMessages.exampleApiCallsLoadError,
                    style: TextStyle(color: Colors.red),
                  ),
                  RaisedButton(
                    onPressed: _refresh,
                    child: const Text(Constants.exampleHackerNewsTapToTry),
                  ),
                ],
              );

            case FutureStatus.fulfilled:
              final List<FeedItem> items = future.result;

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];

                    return ListTile(
                      leading: Text(
                        '${item.points}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '- ${item.user}, ${item.commentsCount} ${Constants.exampleHackerNewsComments}'),
                      onTap: () => store.openUrl(item.url),
                    );
                  },
                ),
              );
          }

          return Container();
        },
      );

  Future _refresh() =>
      (type == FeedType.latest) ? store.fetchLatest() : store.fetchTop();
}
