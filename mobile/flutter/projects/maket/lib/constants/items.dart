const List<Map<String, String>> items = [
  {
    'id': '1',
    'name': 'Spinach',
    'category': 'Vegetable',
  },
  {
    'id': '2',
    'name': 'Orange',
    'category': 'Fruit',
  },
  {
    'id': '3',
    'name': 'Banana',
    'category': 'Fruit',
  },
  {
    'id': '4',
    'name': 'Potatoes',
    'category': 'Vegetable',
  },
  {
    'id': '5',
    'name': 'Sombe',
    'category': 'Vegetable',
  },
  {
    'id': '6',
    'name': 'Milk',
    'category': 'Dairy',
  },
  {
    'id': '6',
    'name': 'Yogurt',
    'category': 'Dairy',
  },
  {
    'id': '6',
    'name': 'Toothpaste',
    'category': 'Toiletry',
  },
  {
    'id': '6',
    'name': 'Soap',
    'category': 'Toiletry',
  },
  {
    'id': '6',
    'name': 'Toothbrush',
    'category': 'Toiletry',
  },
  {
    'id': '6',
    'name': 'Mouthwash',
    'category': 'Toiletry',
  },
  {
    'id': '6',
    'name': 'Spoon',
    'category': 'Utensil',
  },
  {
    'id': '6',
    'name': 'Dishes',
    'category': 'Utensil',
  },
];

class Item {
  static List<Map<String, String>> groupByCategory() {
    final Map<String, List<Map<String, String>>> _items = {};

    for (final item in items) {
      if (_items[item['category']] == null) {
        _items[item['category']] = [item];
      } else {
        _items[item['category']].add(item);
      }
    }

    final List<Map<String, String>> _sorted = [];

    _items.forEach((category, items) {
      final title = {'name': category, 'type': 'title'};
      if (_sorted.indexOf(title) < 0) {
        _sorted.add(title);
      }

      for (final item in items) {
        _sorted.add(item);
      }
    });

    return _sorted;
  }
}
