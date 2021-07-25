import 'package:find_place/model/popular.dart';
import 'package:find_place/theme.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final Popular popular;

  PopularCard(this.popular);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 150,
        width: 120,
        color: Color(0xffF6F7F8),
        child: Column(
          children: [
            Stack(children: [
              Image.asset(
                popular.imageUrl,
                width: 120,
                height: 102,
                fit: BoxFit.cover,
              ),
              (popular.isFavorite)
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icon_star.png',
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ]),
            SizedBox(
              height: 11,
            ),
            Text(
              popular.name,
              style: blackTextStyle.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
