// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String category;
  String imagepath;
  CategoryModel({
    required this.id,
    required this.category,
    required this.imagepath,
  });
  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
        category: data['category'], imagepath: data['imagepath'], id: doc.id);
  }

  CategoryModel copyWith({
    String? id,
    String? category,
    String? imagepath,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      category: category ?? this.category,
      imagepath: imagepath ?? this.imagepath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'imagepath': imagepath,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: (map["id"] ?? '') as String,
      category: (map["category"] ?? '') as String,
      imagepath: (map["imagepath"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(id: $id, category: $category, imagepath: $imagepath)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.imagepath == imagepath;
  }

  @override
  int get hashCode => id.hashCode ^ category.hashCode ^ imagepath.hashCode;
}
