import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/ui/post_list.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/ui/user_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.exampleApiCallsTitle),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        labelColor: Colors.deepPurple,
        tabs: [
          Tab(
            text: Constants.exampleApiCallsPosts,
            icon: Icon(Icons.local_post_office),
          ),
          Tab(
              text: Constants.exampleApiCallsUsers,
              icon: Icon(Icons.verified_user)),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            PostList(),
            UserList(),
          ],
        ),
      ),
    );
  }
}
