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
      budget: json['budget'].toDouble(),
      createDate: json['createdDate'],
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

  static List<ShoppingListModel> shoppingListBodiesFromJson({
    List<dynamic> jsonShoppingListBodies,
  }) {
    List<ShoppingListModel> _shoppingListBodies = [];

    for (Map<String, dynamic> listBody in jsonShoppingListBodies) {
      _shoppingListBodies.add(ShoppingListModel.fromJson(json: listBody));
    }

    return _shoppingListBodies;
  }
}
