import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  Avatar(this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(url))),
    );
  }
}
