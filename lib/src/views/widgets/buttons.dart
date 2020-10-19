import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function action;
  final IconData icon;
  PrimaryButton(this.title, {this.action, this.icon = Icons.camera_alt});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/button_bg.png"))),
      child: FlatButton.icon(
        onPressed: action,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function action;
  final IconData icon;
  SecondaryButton(this.title, {this.action, this.icon = Icons.camera_alt});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.black),
      child: FlatButton.icon(
        onPressed: action,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  final String title;
  final Function action;
  LinkButton(this.title, {this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 8),
          onPressed: action,
          child: Text(
            title,
            style: TextStyle(color: Colors.blue),
          )),
    );
  }
}
