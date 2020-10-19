import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Function onEdit;
  final TextInputType type;
  Input(this.placeholder, {this.onEdit, this.type = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onEdit,
        keyboardType: type,
        decoration: InputDecoration(
            hintText: placeholder,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.red)),
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String placeholder;
  final Function onEdit;
  PasswordInput(this.placeholder, {this.onEdit});
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isRevealed;
  @override
  void initState() {
    super.initState();
    isRevealed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1, color: Colors.grey)),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: widget.onEdit,
                obscureText: !isRevealed,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ),
            IconButton(
                icon: Icon(isRevealed
                    ? Icons.panorama_fish_eye_outlined
                    : Icons.remove_red_eye),
                onPressed: () {
                  setState(() {
                    isRevealed = !isRevealed;
                  });
                })
          ],
        ));
  }
}

class LegendInput extends StatelessWidget {
  final String placeholder;
  final Function onEdit;
  LegendInput(this.placeholder, {this.onEdit});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onEdit,
        minLines: 2,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
