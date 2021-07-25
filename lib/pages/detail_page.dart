import 'package:find_place/model/Detail.dart';
import 'package:find_place/pages/error_page.dart';
import 'package:find_place/pages/image_page.dart';
import 'package:find_place/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:find_place/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:find_place/providers/shop_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {
  final String? placeId;

  DetailPage(this.placeId);

  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<ShopProvider>(context);

    launchUrl(String url) async {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder(
          future: shopProvider.getDetailShop(placeId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Detail detail = snapshot.data as Detail;

              return Stack(
                children: [
                  Image.network(
                    detail.photo?[0].photoReference ??
                        'https://bodybigsize.b-cdn.net/wp-content/uploads/2020/02/noimage-11.png',
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                  ListView(
                    children: [
                      SizedBox(
                        height: 328,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            // NOTE: Title
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: edge),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detail.name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: blackTextStyle.copyWith(
                                              fontSize: 22),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              detail.rating.toString(),
                                              style: purpleTextStyle.copyWith(
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            RatingBar.builder(
                                              initialRating: detail.rating!,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // NOTE: Location
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Location',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: edge),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      detail.address!,
                                      style: greyTextStyle,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      launchUrl(detail.map!);
                                    },
                                    child: Image.asset(
                                      'assets/btn_map.png',
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // NOTE: Photos
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Photos',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 88,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: detail.photo!.length,
                                  itemBuilder: (context, index) {
                                    return Row(children: [
                                      SizedBox(
                                        width: 18,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ImagePage(
                                                  detail.photo, index),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            detail
                                                .photo![index].photoReference!,
                                            width: 110,
                                            height: 88,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  }),
                            ),
                            // NOTE: reviews
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: edge),
                              child: Text(
                                'Reviews',
                                style: regularTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: edge),
                              child: Column(
                                children: detail.reviews!.map((item) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 0,
                                    ),
                                    child: ReviewCard(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: edge,
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/btn_back.png',
                            width: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
