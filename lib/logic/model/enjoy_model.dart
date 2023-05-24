import 'package:cloud_firestore/cloud_firestore.dart';

class EnjoyModel {
  String description;
  String title;
  String image;
  String id;
  String url;

  EnjoyModel({
    required this.description,
    required this.title,
    required this.image,
    required this.id,
    required this.url,
  });

  factory EnjoyModel.fromJson(DocumentSnapshot json) {
    return EnjoyModel(
      description: json['description'],
      title: json['title'],
      image: json['image'],
      id: json['id'],
      url: json['url'],
    );
  }

  factory EnjoyModel.fromQuerySnapshot(QueryDocumentSnapshot json) {
    return EnjoyModel(
      description: json['description'],
      title: json['title'],
      image: json['image'],
      id: json['id'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['title'] = title;
    data['image'] = image;
    data['id'] = id;
    data['url'] = url;
    return data;
  }

  EnjoyModel copyWith({
    String? description,
    String? title,
    String? image,
    String? id,
    String? url,
  }) {
    return EnjoyModel(
      description: description ?? this.description,
      title: title ?? this.title,
      image: image ?? this.image,
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }
}
