import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/mobx_example_github/github_store.dart';

class RepositoryListView extends StatelessWidget {
  final GithubStore store;

  const RepositoryListView(this.store);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Observer(
          builder: (_) {
            if (!store.hasResults) {
              return Container();
            }

            if (store.repositories.isEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('We could not find any repos for user: '),
                  Text(
                    store.user,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }

            return ListView.builder(
                itemCount: store.repositories.length,
                itemBuilder: (_, int index) {
                  final repo = store.repositories[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          repo.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(' (${repo.stargazersCount} ⭐)'),
                      ],
                    ),
                    subtitle: Text(repo.description ?? ''),
                  );
                });
          },
        ),
      );
}
