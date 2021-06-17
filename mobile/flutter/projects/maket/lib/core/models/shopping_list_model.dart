import 'package:maket/core/models/item_model.dart';

class ShoppingListModel {
  String id;
  String name;
  int itemsCount;
  List<ItemModel> items;
  String description;
  double budget;
  String createDate;
  bool selected;
  double spent;

  ShoppingListModel({
    this.id,
    this.name,
    this.itemsCount,
    this.items,
    this.description,
    this.budget,
    this.createDate,
    this.selected: false,
    this.spent: 0.0,
  });

  factory ShoppingListModel.fromJson({Map<String, dynamic> json}) {
    return ShoppingListModel(
      id: json['_id'],
      name: json['name'],
      itemsCount: (json['itemCount'] != null)
          ? json['itemCount']
          : json['items'].length,
      description: json['description'],
      budget: json['budget'].toDouble(),
      createDate: json['createdDate'],
      selected: false,
      spent: (json['spent'] != null) ? json['spent'] : 0.0,
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
