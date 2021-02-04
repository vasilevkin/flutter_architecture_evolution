import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/models/review_model.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/models/reviews_base.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/screens/review_widget.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_reviews/widgets/info_card.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final Reviews _reviewsStore = Reviews();

  final List<int> _stars = [1, 2, 3, 4, 5];
  final TextEditingController _commentController = TextEditingController();
  int _selectedStar;

  @override
  void initState() {
    _selectedStar = null;
    _reviewsStore.initReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: screenWidth * 0.6,
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Tap to Write a review',
                    labelText: 'Write a review',
                  ),
                ),
              ),
              Container(
                child: DropdownButton(
                  hint: Text('Stars'),
                  elevation: 10,
                  value: _selectedStar,
                  items: _stars.map((star) {
                    return DropdownMenuItem<int>(
                      child: Text(star.toString()),
                      value: star,
                    );
                  }).toList(),
                  onChanged: (item) {
                    setState(() {
                      _selectedStar = item;
                    });
                  },
                ),
              ),
              Container(
                child: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () {
                        if (_selectedStar == null) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text("You can't add a review without a star"),
                            duration: Duration(seconds: 2),
                          ));
                        } else if (_commentController.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Review comment can not be ampty'),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          _reviewsStore.addReview(ReviewModel(
                              comment: _commentController.text,
                              stars: _selectedStar));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Observer(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    infoValue: _reviewsStore.numberOfReviews.toString(),
                    infoLabel: 'reviews',
                    cardColor: Colors.green,
                    iconData: Icons.comment,
                  ),
                  InfoCard(
                    infoValue: _reviewsStore.averageStars.toStringAsFixed(2),
                    infoLabel: 'average stars',
                    cardColor: Colors.lightBlue,
                    iconData: Icons.star,
                    key: Key('avgStar'),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 24),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.comment),
                SizedBox(width: 10),
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Observer(
                  builder: (_) => _reviewsStore.reviews.isNotEmpty
                      ? ListView(
                          children:
                              _reviewsStore.reviews.reversed.map((reviewItem) {
                            return ReviewWidget(
                              reviewItem: reviewItem,
                            );
                          }).toList(),
                        )
                      : Text('No reviews yet')),
            ),
          ),
        ],
      ),
    );
  }
}
