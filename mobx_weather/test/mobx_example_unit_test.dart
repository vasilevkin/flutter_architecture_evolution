import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_weather/mobx_example/models/review_model.dart';
import 'package:mobx_weather/mobx_example/models/reviews_base.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Test MobX state class', () async {
    final Reviews _reviewStore = Reviews();

    _reviewStore.initReviews();

    expect(_reviewStore.totalStars, 0);
    expect(_reviewStore.averageStars, 0);

    _reviewStore
        .addReview(ReviewModel(comment: 'Test 3 star review', stars: 3));

    expect(_reviewStore.totalStars, 3);
    expect(_reviewStore.averageStars, 3);

    _reviewStore
        .addReview(ReviewModel(comment: 'Test second 5 star review', stars: 5));

    expect(_reviewStore.totalStars, 8);
    expect(_reviewStore.averageStars, 4);
  });
}
