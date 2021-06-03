import 'package:maket/core/models/item_model.dart';

class ShoppingListModel {
  final String name;
  final List<ItemModel> items;
  final String description;
  final double budget;
  final String createDate;

  ShoppingListModel({
    this.name,
    this.items,
    this.description,
    this.budget,
    this.createDate,
  });

  factory ShoppingListModel.fromJson({Map<String, dynamic> json}) {
    return ShoppingListModel(
      name: json['name'],
      description: json['description'],
      budget: json['budget'],
      createDate: json['createDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "items": ItemModel.itemsToJson(items: this.items),
      "description": this.description,
      "budget": this.budget,
    };
  }
}
