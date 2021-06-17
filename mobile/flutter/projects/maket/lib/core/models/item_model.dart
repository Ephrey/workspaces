import 'package:flutter/material.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/utils/numbers.dart';

class ItemModel {
  String id;
  String name;
  String category;
  double price;
  bool bought;
  int quantity;
  bool selected;

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
      id: (json['_id'] != null) ? json['_id'] : json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] != null)
          ? json['price'].toDouble()
          : Numbers.zero.toDouble(),
      bought: (json['bought'] != null) ? json['bought'] : false,
      quantity: (json['quantity'] != null) ? json['quantity'] : Numbers.one,
      selected: false,
    );
  }

  factory ItemModel.fromJsonSaveListItem({Map<String, dynamic> json}) {
    return ItemModel(
      id: (json['_id'] != null) ? json['_id'] : json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] != null) ? json['price'] : Numbers.zero.toDouble(),
      bought: (json['bought'] != null) ? json['bought'] : false,
      quantity: (json['quantity'] != null) ? json['quantity'] : Numbers.one,
    );
  }

  Map<String, dynamic> toJson() {
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
      'selected': this.selected,
    };
  }

  static List<Map<String, dynamic>> itemsToJson({List<ItemModel> items}) {
    List<Map<String, dynamic>> _items = [];
    for (ItemModel item in items) {
      Map<String, dynamic> _item = item.toJsonListItem();
      _item.remove(ItemConstants.keySelected);
      _items.add(_item);
    }
    return _items;
  }
}
