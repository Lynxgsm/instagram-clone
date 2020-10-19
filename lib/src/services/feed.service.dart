import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/src/models/feed.model.dart';

class FeedService {
  static Future<DocumentReference> sendFeed(FeedModel feed) async {
    return await Firestore.instance.collection("feeds").add(feed.toJSON());
  }
}
