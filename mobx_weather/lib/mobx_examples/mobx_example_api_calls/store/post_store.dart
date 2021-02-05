import 'package:mobx/mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/data/data_models.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_api_calls/network/network_service.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  final NetworkService httpClient = NetworkService();

  @observable
  ObservableFuture<List<Post>> postsListFuture;

  @action
  Future fetchPosts() => postsListFuture = ObservableFuture(httpClient
      .getPosts(Constants.exampleApiCallsPostsEndpoint)
      .then((posts) => posts));

  void getThePosts() {
    fetchPosts();
  }
}
