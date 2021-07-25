import 'package:find_place/model/shop.dart';
import 'package:find_place/theme.dart';
import 'package:flutter/material.dart';
import 'package:find_place/pages/detail_page.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  ShopCard(this.shop);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(shop.placeId),
          ),
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(
                    shop.photo ??
                        'https://bodybigsize.b-cdn.net/wp-content/uploads/2020/02/noimage-11.png',
                    width: 130,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  shop.distance!.toString() + ' km',
                  style: purpleTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '${shop.address}',
                  maxLines: 2,
                  style: greyTextStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
