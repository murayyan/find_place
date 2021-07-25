import 'dart:convert';
import 'package:find_place/model/Detail.dart';
import 'package:flutter/material.dart';
import 'package:find_place/model/shop.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class ShopProvider extends ChangeNotifier {
  getShops() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var lng = position.longitude;

    var url = Uri.parse(
        'http://localhost:8080/places?lat=${lat}&lng=${lng}&category=coffee');
    print(url);
    var result = await http.get(url);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(result.body);
      List data = response["data"];
      List<Shop> shops = data.map((item) => Shop.fromJson(item)).toList();
      return shops;
    }
    return <Shop>[];
  }

  getDetailShop(String? placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=AIzaSyDyZtVVw7ZuBWeZiXLaPhKaYueL7HGMkvU&language=id');
    var result = await http.get(url);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(result.body);
      Object data = response["result"];
      Detail detail = Detail.fromJson(data);
      return detail;
    }
    return {};
  }
}
