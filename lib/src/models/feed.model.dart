import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/src/models/user.model.dart';

class FeedModel {
  UserModel author;
  Timestamp date;
  String description;
  List<String> images;
  List<String> tags;
  int views;
  String place;

  FeedModel(
      {this.author,
      this.date,
      this.description,
      this.images,
      this.tags,
      this.place,
      this.views});

  factory FeedModel.fromJSON(Map<String, dynamic> json) {
    UserModel _author = UserModel.fromJSON(json["author"]);
    List<String> _images = [];
    List<String> _tags = [];

    for (int i = 0; i < json["images"].length; i++) {
      _images.add(json["images"][i]);
    }

    for (int i = 0; i < json["tags"].length; i++) {
      _tags.add(json["tags"][i]);
    }

    return FeedModel(
        author: _author,
        date: json["date"] as Timestamp,
        description: json["description"] as String,
        images: _images,
        tags: _tags,
        place: json["place"] as String,
        views: json["views"] as int);
  }

  Map<String, dynamic> toJSON() => {
        "author": author.toJSON(),
        "images": images,
        "date": date,
        "description": description,
        "tags": tags,
        "place": place,
        "views": views
      };
}
