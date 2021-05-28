import 'package:flutter/material.dart';
import 'package:maket/utils/numbers.dart';

class ItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final bool bought;
  final int quantity;
  final bool selected;

  ItemModel({
    this.id,
    @required this.name,
    @required this.category,
    this.price: 0.0,
    this.bought: false,
    this.quantity: Numbers.one,
    this.selected: false,
  });

  factory ItemModel.fromJson({Map<String, String> json}) {
    return ItemModel(
      name: json['name'],
      category: json['category'],
    );
  }

  factory ItemModel.fromJsonListItem({Map<String, dynamic> json}) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] != null) ? json['price'] : Numbers.zero.toDouble(),
      bought: (json['bought'] != null) ? json['bought'] : false,
      quantity: (json['quantity'] != null) ? json['quantity'] : Numbers.one,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': this.name,
      'category': this.category,
    };
  }

  Map<String, dynamic> toJsonListItem() {
    return {
      'id': this.id,
      'name': this.name,
      'category': this.category,
      'price': this.price,
      'bought': this.bought,
      'quantity': this.quantity,
    };
  }
}
