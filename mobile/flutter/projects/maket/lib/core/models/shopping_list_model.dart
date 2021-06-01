class ShoppingListModel {
  final String name;
  final List<Map<String, dynamic>> items;
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
      "items": this.items,
      "description": this.description,
      "budget": this.budget,
    };
  }
}
