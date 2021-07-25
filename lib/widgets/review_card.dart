import 'package:find_place/model/review.dart';
import 'package:find_place/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              initialRating: review.rating!.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              review.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: regularTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              review.time!,
              style: greyTextStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              review.text!,
              style: greyTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
