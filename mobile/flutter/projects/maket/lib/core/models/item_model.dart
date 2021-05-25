import 'package:flutter/material.dart';

class ItemModel {
  final String name;
  final String category;

  ItemModel({@required this.name, @required this.category});

  factory ItemModel.fromJson({Map<String, String> json}) {
    return ItemModel(name: json['name'], category: json['category']);
  }

  Map<String, String> toJson() {
    return {'name': this.name, 'category': this.category};
  }
}
