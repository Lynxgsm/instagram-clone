import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/models/feed.model.dart';
import 'package:instagram/src/views/screens/home/feed/feed.viewmodel.dart';
import 'package:instagram/src/views/widgets/avatar.dart';
import 'package:instagram/src/views/widgets/loader.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        builder: (context, model, _) => Container(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('feeds')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Loader();
                    }
                    return ListView(
                      children: snapshot.data.documents.map((e) {
                        return FeedCard(FeedModel.fromJSON(e.data));
                      }).toList(),
                    );
                  }),
            ),
        viewModelBuilder: () => FeedViewModel());
  }
}

class FeedCard extends StatelessWidget {
  final FeedModel feed;
  FeedCard(this.feed);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 16),
            leading: feed.author.avatar == ""
                ? CircleAvatar()
                : Avatar(feed.author.avatar),
            title: Text(
              feed.author.username,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            subtitle: Text(feed.place),
            // trailing:
            //     IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
          ),
          ImageDisplay(feed.images),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.send_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${feed.views} Views"),
                RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      text: "${feed.author.username} ",
                      children: [
                        TextSpan(
                          text: feed.description,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
                Viewing.spacing(height: 8),
                Row(
                  children: feed.tags.map((e) => Tag(e)).toList(),
                )
              ],
            ),
          ),
          Viewing.spacing(height: 8),
          Divider()
        ],
      ),
    );
  }
}

class ImageDisplay extends StatelessWidget {
  final List<String> images;
  ImageDisplay(this.images);
  @override
  Widget build(BuildContext context) {
    print(images);
    return Container(
        height: Viewing.height(context) * .5,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: images.length,
          children: images
              .map(
                (e) => CachedNetworkImage(
                  imageUrl: e,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: Container(
                          height: Viewing.height(context) * .5,
                          width: double.infinity,
                        )),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
              .toList(),
        ));
  }
}

Container cellItem(String image) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
  );
}

class Tag extends StatelessWidget {
  final String text;
  Tag(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "#${text.toLowerCase()} ",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
