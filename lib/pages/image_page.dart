import 'package:find_place/model/photo.dart';
import 'package:flutter/material.dart';
import 'package:find_place/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagePage extends StatelessWidget {
  final List<Photo>? photos;
  final int? index;

  ImagePage(this.photos, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 600.0,
                  aspectRatio: 1.0,
                  viewportFraction: 1,
                  initialPage: index!,
                ),
                items: photos?.map((photo) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        // decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(
                          photo.photoReference!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
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
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
