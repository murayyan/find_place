import 'package:find_place/pages/culinary_page.dart';
import 'package:find_place/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:find_place/theme.dart';
import 'package:find_place/widgets/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[HomePage(), CulinaryPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pageList,
      ),
      floatingActionButton: Container(
        height: 65,
        width: MediaQuery.of(context).size.width - (2 * edge),
        margin: EdgeInsets.symmetric(horizontal: edge),
        decoration: BoxDecoration(
          color: Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: BottomNav(
                imageUrl: 'assets/icon_home.png',
                isActive: pageIndex == 0,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: BottomNav(
                imageUrl: 'assets/icon_message.png',
                isActive: pageIndex == 1,
              ),
            ),
            BottomNav(
              imageUrl: 'assets/icon_list.png',
              isActive: false,
            ),
            BottomNav(
              imageUrl: 'assets/icon_love.png',
              isActive: false,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
