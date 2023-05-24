import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  String image;
  String uid;
  String date;

  UserModel({
    required this.email,
    required this.name,
    required this.image,
    required this.uid,
    required this.date,
  });

  factory UserModel.fromJson(DocumentSnapshot json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      image: json['image'],
      uid: json['uid'],
      date: json['date'],
    );
  }
  factory UserModel.fromQuerySnapshot(QueryDocumentSnapshot json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      image: json['image'],
      uid: json['uid'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['image'] = image;
    data['uid'] = uid;
    data['date'] = date;
    return data;
  }

  @override
  String toString() {
    return 'name - $name, email - $email';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.image == image &&
        other.uid == uid &&
        other.date == date;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        image.hashCode ^
        uid.hashCode ^
        date.hashCode;
  }
}
