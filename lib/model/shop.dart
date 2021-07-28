import 'package:find_place/model/photo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Shop {
  String? placeId;
  String? name;
  String? photo;
  String? address;
  double? latitude;
  double? longitude;
  num? distance;

  Shop(this.placeId, this.name, this.photo, this.address, this.latitude,
      this.longitude, this.distance);

  @override
  String toString() {
    return 'Sample{NAME: $name, distance: $distance}\n';
  }

  Shop.fromJson(Map<String, dynamic> json) {
    var apikey = dotenv.env['GOOGLE_API_KEY'];
    var photoReference = json['photo'];
    placeId = json['place_id'];
    name = json['name'];
    photo =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=${photoReference}&key=$apikey';
    address = json['address'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
    distance = json['distance'];
  }

  Shop.fromJson2(Map<String, dynamic> json, double lat, double lng) {
    List<Photo> photos = [];
    if (json['photos'] != null) {
      var listPhoto = json['photos'] as List;
      photos = listPhoto.map((i) => Photo.fromJson(i)).toList();
    }

    placeId = json['place_id'];
    name = json['name'];
    photo = photos.length > 0 ? photos[0].photoReference : null;
    address = json['formatted_address'];
    latitude = Geometry.fromJson(json['geometry']).location?.lat;
    longitude = Geometry.fromJson(json['geometry']).location?.lng;

    distance = double.parse(
        (Geolocator.distanceBetween(lat, lng, latitude!, longitude!) / 1000)
            .toStringAsFixed(2));
  }
}

class Geometry {
  Location? location;

  Geometry(this.location);

  Geometry.fromJson(json) {
    location = Location.fromJson(json['location']);
  }
}

class Location {
  double? lat;
  double? lng;

  Location(this.lat, this.lng);

  Location.fromJson(json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
