class ItemConstants {
  static const String itemGroupTitle = 'itemGroupTitle';

  // item model instance members
  static const String keySelected = 'selected';

  static List<String> _itemCategories = [
    'Accessory',
    'Dairy',
    'Drinks',
    'Fruit',
    'Fabric',
    'Grain',
    'Meats',
    'Paste or Spread',
    'Protein',
    'Toiletry',
    'Utensil',
    'Vegetable',
    'Sugary',
    'Others',
  ];

  static List<String> getCategories() {
    return _itemCategories;
  }
}
