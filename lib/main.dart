import 'package:find_place/pages/splash_page.dart';
import 'package:find_place/providers/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShopProvider(),
      child: MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
