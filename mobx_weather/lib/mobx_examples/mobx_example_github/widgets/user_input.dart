import 'package:flutter/material.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_github/github_store.dart';

class UserInput extends StatelessWidget {
  final GithubStore store;

  const UserInput(this.store);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextField(
              autocorrect: false,
              autofocus: true,
              onSubmitted: (String user) {
                store.setUser(user);

                // ignore: cascade_invocations
                store.fetchRepos();
              },
            ),
          ),
        ),
        IconButton(icon: const Icon(Icons.search), onPressed: store.fetchRepos),
      ],
    );
  }
}
