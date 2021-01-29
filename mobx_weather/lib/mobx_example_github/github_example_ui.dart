import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_example_github/github_store.dart';
import 'package:mobx_weather/mobx_example_github/widgets/loading_indicator.dart';
import 'package:mobx_weather/mobx_example_github/widgets/repository_listview.dart';
import 'package:mobx_weather/mobx_example_github/widgets/show_error.dart';
import 'package:mobx_weather/mobx_example_github/widgets/user_input.dart';

class GithubExample extends StatefulWidget {
  @override
  _GithubExampleState createState() => _GithubExampleState();
}

class _GithubExampleState extends State<GithubExample> {
  final GithubStore store = GithubStore();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(Constants.exampleGitHubTitle)),
        body: Column(
          children: [
            UserInput(store),
            ShowError(store),
            LoadingIndicator(store),
            RepositoryListView(store),
          ],
        ),
      );
}
