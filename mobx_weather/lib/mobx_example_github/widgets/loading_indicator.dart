import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/mobx_example_github/github_store.dart';

class LoadingIndicator extends StatelessWidget {
  final GithubStore store;

  const LoadingIndicator(this.store);

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => store.fetchReposFuture.status == FutureStatus.pending
            ? const LinearProgressIndicator()
            : Container(),
      );
}
