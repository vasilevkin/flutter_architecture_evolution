import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/data/data_models.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/network/network_service.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final NetworkService httpClient = NetworkService();

  @observable
  ObservableFuture<List<User>> userListFuture;

  @action
  Future fetchUsers() => userListFuture = ObservableFuture(httpClient
      .getData(Constants.exampleApiCallsUsersEndpoint)
      .then((users) => users));

  void getTheUsers() {
    fetchUsers();
  }
}
