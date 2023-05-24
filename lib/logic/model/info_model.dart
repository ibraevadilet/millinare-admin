// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoModel {
  String description;
  String title;
  String image;
  String id;

  InfoModel({
    required this.description,
    required this.title,
    required this.image,
    required this.id,
  });

  factory InfoModel.fromJson(DocumentSnapshot json) {
    return InfoModel(
      description: json['description'],
      title: json['title'],
      image: json['image'],
      id: json['id'],
    );
  }

  factory InfoModel.fromQuerySnapshot(QueryDocumentSnapshot json) {
    return InfoModel(
      description: json['description'],
      title: json['title'],
      image: json['image'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['title'] = title;
    data['image'] = image;
    data['id'] = id;
    return data;
  }

  InfoModel copyWith({
    String? description,
    String? title,
    String? image,
    String? id,
  }) {
    return InfoModel(
      description: description ?? this.description,
      title: title ?? this.title,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }
}
