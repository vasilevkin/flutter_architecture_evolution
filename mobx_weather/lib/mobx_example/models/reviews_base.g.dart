// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Reviews on ReviewsBase, Store {
  Computed<int> _$numberOfReviewsComputed;

  @override
  int get numberOfReviews =>
      (_$numberOfReviewsComputed ??= Computed<int>(() => super.numberOfReviews,
              name: 'ReviewsBase.numberOfReviews'))
          .value;

  final _$reviewsAtom = Atom(name: 'ReviewsBase.reviews');

  @override
  ObservableList<ReviewModel> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(ObservableList<ReviewModel> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
    });
  }

  final _$averageStarsAtom = Atom(name: 'ReviewsBase.averageStars');

  @override
  double get averageStars {
    _$averageStarsAtom.reportRead();
    return super.averageStars;
  }

  @override
  set averageStars(double value) {
    _$averageStarsAtom.reportWrite(value, super.averageStars, () {
      super.averageStars = value;
    });
  }

  final _$initReviewsAsyncAction = AsyncAction('ReviewsBase.initReviews');

  @override
  Future<void> initReviews() {
    return _$initReviewsAsyncAction.run(() => super.initReviews());
  }

  final _$ReviewsBaseActionController = ActionController(name: 'ReviewsBase');

  @override
  void addReview(ReviewModel newReview) {
    final _$actionInfo = _$ReviewsBaseActionController.startAction(
        name: 'ReviewsBase.addReview');
    try {
      return super.addReview(newReview);
    } finally {
      _$ReviewsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
reviews: ${reviews},
averageStars: ${averageStars},
numberOfReviews: ${numberOfReviews}
    ''';
  }
}
