import 'package:find_place/providers/shop_provider.dart';
import 'package:find_place/theme.dart';
import 'package:find_place/widgets/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:find_place/model/shop.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var shopProvider = Provider.of<ShopProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            // NOTE: TITLE/HEADER
            SizedBox(
              height: edge,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Coffee Shop',
                style: blackTextStyle.copyWith(fontSize: 24),
              ),
            ),
            // SizedBox(
            //   height: 2,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: edge),
            //   child: Text(
            //     'Mencari coffee shop yang cozy',
            //     style: greyTextStyle.copyWith(fontSize: 16),
            //   ),
            // ),
            // // NOTE: Popular shop
            // Padding(
            //   padding: EdgeInsets.only(left: edge),
            //   child: Text(
            //     'Popular Places',
            //     style: regularTextStyle.copyWith(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 16,
            // ),
            // Container(
            //   height: 150,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       SizedBox(
            //         width: 24,
            //       ),
            //       PopularCard(
            //         Popular(
            //           1,
            //           'Robucca',
            //           'assets/city1.png',
            //         ),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       PopularCard(
            //         Popular(
            //           2,
            //           'Nakoa',
            //           'assets/city2.png',
            //         ),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       PopularCard(
            //         Popular(
            //           3,
            //           'Lafayette',
            //           'assets/city3.png',
            //           true,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 24,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 55,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: edge,
                right: edge,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: searchBarColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'Search Coffee Shop...',
                        hintStyle: greyTextStyle,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // NOTE: Recommended Coffee shop
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Nearby Coffee Shops',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: edge),
              child: FutureBuilder(
                future: shopProvider.getShops(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Shop> data = snapshot.data as List<Shop>;

                    int index = 0;
                    return Column(
                      children: data.map((item) {
                        index++;
                        return Container(
                          margin: EdgeInsets.only(
                            top: index == 1 ? 0 : 30,
                          ),
                          child: ShopCard(item),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50 + edge,
            ),
          ],
        ),
      ),
    );
  }
}
