class Photo {
  int? height;
  int? width;
  List<String>? htmlAttributions;
  String? photoReference;

  Photo(this.height, this.width, this.htmlAttributions, this.photoReference);

  @override
  String toString() {
    return 'Sample{photoReference: $photoReference}';
  }

  Photo.fromJson(Map<String, dynamic> json) {
    var photo = json['photo_reference'];
    height = json['height'];
    width = json['width'];
    htmlAttributions = List<String>.from(json['html_attributions']);
    photoReference =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photo}&key=AIzaSyDyZtVVw7ZuBWeZiXLaPhKaYueL7HGMkvU';
  }
}
