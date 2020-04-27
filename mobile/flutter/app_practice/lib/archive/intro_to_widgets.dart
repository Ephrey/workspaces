import 'package:flutter/material.dart';

// void main() => runApp(App());

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Shopping Card',
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('Shopping List'),
//           ),
//           body: ShoppingList(
//             products: <Product>[
//               Product(name: 'Egg'),
//               Product(name: 'Flour'),
//               Product(name: 'Chocolate chip')
//             ],
//           ),
//         ));
//   }
// }

// class Product {
//   const Product({this.name});
//   final String name;
// }

// typedef void CartChangedCallback(Product product, bool inCart);

// class ShoppingListItem extends StatelessWidget {
//   ShoppingListItem({this.product, this.inCart, this.onCartChanged})
//       : super(key: ObjectKey(product));

//   final Product product;
//   final bool inCart;
//   final CartChangedCallback onCartChanged;

//   Color _getColor(BuildContext context) {
//     return inCart ? Colors.black54 : Theme.of(context).primaryColor;
//   }

//   TextStyle _getTextStyle(BuildContext context) {
//     if (!inCart) return null;

//     return TextStyle(
//         color: Colors.black54, decoration: TextDecoration.lineThrough);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         onCartChanged(product, inCart);
//       },
//       leading: CircleAvatar(
//         child: Text(product.name[0]),
//         backgroundColor: _getColor(context),
//       ),
//       title: Text(
//         product.name,
//         style: _getTextStyle(context),
//       ),
//     );
//   }
// }

// class ShoppingList extends StatefulWidget {
//   ShoppingList({Key key, this.products}) : super(key: key);

//   final List<Product> products;

//   @override
//   ShoppingListState createState() => ShoppingListState();
// }

// class ShoppingListState extends State<ShoppingList> {
//   Set<Product> _shoppingCart = Set<Product>();

//   void _handleCartChanged(Product product, bool inCart) {
//     setState(() {
//       if (!inCart) {
//         _shoppingCart.add(product);
//       } else {
//         _shoppingCart.remove(product);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       children: widget.products.map((Product product) {
//         return ShoppingListItem(
//             product: product,
//             inCart: _shoppingCart.contains(product),
//             onCartChanged: _handleCartChanged);
//       }).toList(),
//     );
//   }
// }

// void main() => runApp(App());

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Counter App',
//       theme: ThemeData(primarySwatch: Colors.red),
//       home: Counter(),
//     );
//   }
// }

// class CounterDisplay extends StatelessWidget {
//   CounterDisplay({Key key, this.count});

//   final int count;

//   @override
//   Widget build(BuildContext context) {
//     return Text('Count : $count');
//   }
// }

// class CounterIncrementor extends StatelessWidget {
//   CounterIncrementor({Key key, this.onPressed});

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: onPressed,
//       child: Text('Increment'),
//     );
//   }
// }

// class Counter extends StatefulWidget {
//   @override
//   CounterState createState() => CounterState();
// }

// class CounterState extends State<Counter> {
//   int count = 0;

//   void _incrementor() {
//     setState(() {
//       count++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CounterDisplay(count: count),
//             CounterIncrementor(onPressed: _incrementor),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Counter extends StatefulWidget {
//   @override
//   CounterState createState() => CounterState();
// }

// class CounterState extends State<Counter> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Counter Demo'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('You have clicked the button $_counter times'),
//               RaisedButton(
//                 child: Text('Increment +'),
//                 onPressed: _incrementCounter,
//               ),
//               Text('Count : $_counter')
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _incrementCounter,
//           child: Icon(Icons.add),
//         ));
//   }
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Tutorial',
//       theme: ThemeData(primaryColor: Colors.red),
//       home: TutorialHome(),
//     );
//   }
// }

// class TutorialHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           tooltip: 'Navigation Menu',
//           onPressed: () => print('Menu button clicked ...'),
//         ),
//         title: Text('Example Title'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: () => print('Search begun ...'),
//           )
//         ],
//       ),
//       body: Center(
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[Text('Hello, world :)'), MyButton()]),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         tooltip: 'Add',
//         onPressed: () => print('Adding stuff ...'),
//       ),
//     );
//   }
// }

// class MyButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => print('rMyButton was tapped ...'),
//       child: Container(
//         height: 36.0,
//         padding: const EdgeInsets.all(8.0),
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         decoration: BoxDecoration(
//             color: Colors.lightGreen[500],
//             borderRadius: BorderRadius.circular(5.0)),
//         child: Center(child: Text('Engage')),
//       ),
//     );
//   }
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Practice Flutter",
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('Title'),
//           ),
//           body: MyScaffold(),
//         ));
//   }
// }

// class MyAppBar extends StatelessWidget {
//   MyAppBar({this.title});

//   final Widget title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.0,
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       decoration: BoxDecoration(color: Colors.blue[500]),
//       child: Row(
//         children: <Widget>[
//           IconButton(
//               icon: Icon(Icons.menu),
//               tooltip: 'Navigation menu',
//               onPressed: null),
//           Expanded(
//             child: Center(child: title),
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             tooltip: 'Search',
//             onPressed: null,
//           )
//         ],
//       ),
//     );
//   }
// }

// class MyScaffold extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         children: <Widget>[
//           MyAppBar(
//             title: Text(
//               'Example Title',
//               style: Theme.of(context).primaryTextTheme.title,
//             ),
//           ),
//           Expanded(
//             child: Center(child: Text('Hello, world')),
//           )
//         ],
//       ),
//     );
//   }
// }
