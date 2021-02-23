import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_hacker_news/feed_items_view.dart';import 'package:mobx_weather/mobx_examples/mobx_example_hacker_news/hacker_news_store.dart';

class HackerNewsExample extends StatefulWidget {
  @override
  _HackerNewsExampleState createState() => _HackerNewsExampleState();
}

class _HackerNewsExampleState extends State<HackerNewsExample>
    with SingleTickerProviderStateMixin {
  final HackerNewsStore store = HackerNewsStore();

  TabController _tabController;
  final _tabs = [FeedType.latest, FeedType.top];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_onTabChange);

    store.loadNews(_tabs.first);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Constants.exampleHackerNewsTitle),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: Constants.exampleHackerNewsNewest),
              Tab(text: Constants.exampleHackerNewsTop),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: [
              FeedItemsView(store, FeedType.latest),
              FeedItemsView(store, FeedType.top),
            ],
          ),
        ),
      );

  void _onTabChange() {
    store.loadNews(_tabs[_tabController.index]);
  }
}
