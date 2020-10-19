class UserModel {
  String username;
  String uid;
  String avatar;

  UserModel({this.uid, this.username, this.avatar});

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
        username: json["username"] as String,
        uid: json["uid"] as String,
        avatar: json["avatar"] as String);
  }

  Map<String, dynamic> toJSON() {
    return {"username": username, "avatar": avatar, "uid": uid};
  }
}
