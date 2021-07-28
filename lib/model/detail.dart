import 'package:find_place/model/photo.dart';
import 'package:find_place/model/review.dart';

class Detail {
  String? placeId;
  String? name;
  List<Photo>? photo;
  List<String>? openingHours;
  List<Review>? reviews;
  double? rating;
  String? map;
  String? phone;
  String? address;

  Detail(this.placeId, this.name, this.photo, this.openingHours, this.reviews,
      this.rating, this.map, this.phone, this.address);

  @override
  String toString() {
    return 'Sample{Review: $reviews \n';
  }

  Detail.fromJson(json) {
    List<Photo> photos = [];
    if (json['photos'] != null) {
      var listPhoto = json['photos'] as List;
      photos = listPhoto.map((i) => Photo.fromJson(i)).toList();
    }

    List<String>? hours;
    if (json['opening_hours'] != null) {
      WorkingHours open = WorkingHours.fromJson(json['opening_hours']);
      hours = open.openingHours;
    }

    List<Review> listReviews = [];
    if (json['reviews'] != null) {
      var listReview = json['reviews'] as List;
      listReviews = listReview.map((i) => Review.fromJson(i)).toList();
    }

    placeId = json['place_id'];
    name = json['name'];
    photo = photos;
    openingHours = hours ?? [];
    reviews = listReviews;
    rating = json['rating'];
    map = json['url'];
    phone = json['international_phone_number'];
    address = json['vicinity'];
  }
}

class WorkingHours {
  bool? isOpen;
  List<String>? openingHours;

  WorkingHours(this.isOpen, this.openingHours);

  WorkingHours.fromJson(json) {
    isOpen = json['open_now'];
    List<String> hours = new List<String>.from(json['weekday_text']);

    openingHours = hours;
  }
}
