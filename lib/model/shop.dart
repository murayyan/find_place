class Shop {
  String? placeId;
  String? name;
  String? photo;
  String? address;
  num? latitude;
  num? longitude;
  num? distance;

  Shop(this.placeId, this.name, this.photo, this.address, this.latitude,
      this.longitude, this.distance);

  @override
  String toString() {
    return 'Sample{NAME: $name, distance: $distance}\n';
  }

  Shop.fromJson(Map<String, dynamic> json) {
    var photoReference = json['photo'];
    placeId = json['place_id'];
    name = json['name'];
    photo =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=${photoReference}&key=AIzaSyDyZtVVw7ZuBWeZiXLaPhKaYueL7HGMkvU';
    address = json['address'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
    distance = json['distance'];
  }
}
