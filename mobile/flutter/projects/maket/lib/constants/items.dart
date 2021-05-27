const List<Map<String, dynamic>> items = [
  {
    'id': '1',
    'name': 'Spinach',
    'category': 'Vegetable',
    'price': 20.0,
    'bought': true,
    'quantity': 3,
    'select': false,
  },
  {
    'id': '2',
    'name': 'Orange',
    'category': 'Fruit',
    'select': false,
  },
  {
    'id': '3',
    'name': 'Banana',
    'category': 'Fruit',
    'price': 10.0,
    'bought': true,
    'quantity': 2,
    'select': false,
  },
  {
    'id': '4',
    'name': 'Potatoes',
    'category': 'Vegetable',
    'select': false,
  },
  {
    'id': '5',
    'name': 'Sombe',
    'category': 'Vegetable',
    'price': 130.0,
    'bought': true,
    'quantity': 1,
    'select': false,
  },
  {
    'id': '6',
    'name': 'Milk',
    'category': 'Dairy',
    'select': false,
  },
  {
    'id': '6',
    'name': 'Yogurt',
    'category': 'Dairy',
    'price': 44.99,
    'bought': true,
    'quantity': 5,
    'select': false,
  },
  {
    'id': '6',
    'name': 'Toothpaste',
    'category': 'Toiletry',
    'select': false,
  },
  {
    'id': '6',
    'name': 'Soap',
    'category': 'Toiletry',
    'price': 13.33,
    'bought': true,
    'quantity': 2,
    'select': false,
  },
  {
    'id': '6',
    'name': 'Toothbrush',
    'category': 'Toiletry',
    'select': false,
  },
  {
    'id': '6',
    'name': 'Mouthwash',
    'category': 'Toiletry',
    'price': 79.22,
    'bought': true,
    'quantity': 1,
    'select': false,
  },
  {
    'id': '6',
    'name': 'Spoon',
    'category': 'Utensil',
    'select': false,
  },
  {
    'id': '6',
    'name': 'Dishes',
    'category': 'Utensil',
    'select': false,
  },
];

class Item {
  static List<Map<String, dynamic>> groupByCategory() {
    final Map<String, List<Map<String, dynamic>>> _items = {};

    for (final item in items) {
      if (_items[item['category']] == null) {
        _items[item['category']] = [item];
      } else {
        _items[item['category']].add(item);
      }
    }

    final List<Map<String, dynamic>> _sorted = [];

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
