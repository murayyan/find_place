class Review {
  String? name;
  int? rating;
  String? text;
  String? time;
  String? profile;

  Review(this.name, this.rating, this.text, this.profile);

  @override
  String toString() {
    return 'Sample{NAME: $name, rating: $rating}\n';
  }

  Review.fromJson(Map<String, dynamic> json) {
    name = json['author_name'];
    rating = json['rating'];
    text = json['text'];
    time = json['relative_time_description'];
    profile = json['profile_photo_url'];
  }
}
