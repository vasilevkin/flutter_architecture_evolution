import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/data/data_models.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/store/user_store.dart';

class UserList extends StatelessWidget {
  final UserStore store = UserStore();

  UserList() {
    store.getTheUsers();
  }

  @override
  Widget build(BuildContext context) {
    final future = store.userListFuture;

    return Observer(builder: (_) {
      switch (future.status) {
        case FutureStatus.pending:
          return Center(child: LinearProgressIndicator());

        case FutureStatus.fulfilled:
          final List<User> users = future.result;

          print('MobX example api calls:: users= $users');

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: 25,
                  ),
                  title: Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Text(
                    user.followers.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                );
              },
            ),
          );

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

        default:
          return Container();
      }
    });
  }

  Future<void> _refresh() => store.fetchUsers();
}
