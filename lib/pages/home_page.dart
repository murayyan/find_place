import 'dart:async';

import 'package:find_place/providers/shopAPI.dart';
import 'package:find_place/theme.dart';
import 'package:find_place/widgets/search_widget.dart';
import 'package:find_place/widgets/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:find_place/model/shop.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Shop> shops = [];
  List<Shop> initShops = [];
  List<Shop> searchShops = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    initShops = await ShopAPI.getShop('');
    print(shops);

    setState(() => this.shops = initShops);
  }

  Future search(String query) async => debounce(() async {
        if (query != '') searchShops = await ShopAPI.search(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.shops = query == '' ? initShops : searchShops;
        });
      });

  Widget getWidget() {
    if (shops.isNotEmpty) {
      if (shops[0].name == null) {
        return Container(
          height: 100,
          child: Center(
            child: Text(
              'Not Found',
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
        );
      }
      List<Shop> data = shops;

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
  }

  @override
  Widget build(BuildContext context) {
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
            SearchWidget(
              text: query,
              hintText: 'Place Name',
              onChanged: search,
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
                child: getWidget()),
            SizedBox(
              height: 50 + edge,
            ),
          ],
        ),
      ),
    );
  }
}
