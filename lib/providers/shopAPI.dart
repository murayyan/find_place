import 'dart:convert';
import 'package:find_place/model/Detail.dart';
import 'package:find_place/model/shop.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShopAPI {
  static Future<List<Shop>> search(String? query) async {
    var apikey = dotenv.env['GOOGLE_API_KEY'];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var lng = position.longitude;

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$query&inputtype=textquery&fields=place_id,photos,formatted_address,name,opening_hours,rating,geometry&key=$apikey');
    print(url);
    var result = await http.get(url);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(result.body);
      List data = response["candidates"];
      if (data.isEmpty) {
        return <Shop>[Shop(null, null, null, null, null, null, null)];
      }
      List<Shop> shops =
          data.map((item) => Shop.fromJson2(item, lat, lng)).toList();
      return shops;
    }
    return <Shop>[];
  }

  static Future<List<Shop>> getShop(String? query) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lat = position.latitude;
    var lng = position.longitude;

    var url = Uri.parse(
        'http://api.murayyan.dev/places?lat=$lat&lng=$lng&keyword=$query&category=coffee');
    print(url);
    var result = await http.get(url);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = jsonDecode(result.body);
      List data = response["data"];
      if (data.isEmpty) {
        return <Shop>[Shop(null, null, null, null, null, null, null)];
      }
      List<Shop> shops = data.map((item) => Shop.fromJson(item)).toList();
      return shops;
    }
    return <Shop>[];
  }

  static Future<Object> getDetailShop(String? placeId) async {
    var apikey = dotenv.env['GOOGLE_API_KEY'];
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apikey&language=id');
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
