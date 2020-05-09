import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      home: Scaffold(
        appBar: AppBar(
          title: Text('App :)'),
        ),
        body: _buildCard(),
      ),
    );
  }
}

Widget _buildCard() => SizedBox(
      height: 210,
      child: Card(
        elevation: 10,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                '29 Lady May Street',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('Athlone'),
              leading: Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                '6 Queen Rd',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('contact@ephriamilunga.com'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );

// Widget _stack() {
//   return Stack(
//     // alignment: Alignment.bottomCenter,
//     children: <Widget>[
//       Image.asset('assets/images/8.jpeg'),
//       Positioned(
//         left: 0,
//         right: 0,
//         bottom: 0,
//         child: Container(
//           // padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
//           child: Row(
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 color: Colors.white,
//                 onPressed: () => print('Delete photo'),
//               ),
//               IconButton(
//                 icon: Icon(Icons.share),
//                 color: Colors.white,
//                 onPressed: () => print('Share photo'),
//               ),
//               IconButton(
//                 icon: Icon(Icons.edit),
//                 color: Colors.white,
//                 onPressed: () => print('Edit photo'),
//               )
//             ],
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.black54,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildStack() {
//   return Stack(
//     alignment: Alignment.center,
//     children: <Widget>[
//       CircleAvatar(
//         backgroundImage: AssetImage('assets/images/1.jpeg'),
//         radius: 100,
//       ),
//       Container(
//         decoration: BoxDecoration(color: Colors.black45),
//         child: Text(
//           'Nancy T.',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ],
//   );
// }

// ListView(
//           children: <Widget>[
//             _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
//             _tile('The Castro Theater', '429 Castro St', Icons.theaters),
//             _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
//             _tile('Roxie Theater', '3117 16th St', Icons.theaters),
//             _tile('United Artists Stonestown Twin', '501 Buckingham Way',
//                 Icons.theaters),
//             _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
//             Divider(),
//             _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd',
//                 Icons.restaurant),
//             _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave',
//                 Icons.restaurant),
//             _tile('Chaiya Thai Restaurant', '272 Claremont Blvd',
//                 Icons.restaurant),
//             _tile('La Ciccia', '291 30th St', Icons.restaurant),
//           ],
//         ),

// ListTile _tile(String title, String subTitle, IconData icon) {
//   return ListTile(
//     onTap: () {
//       print(title);
//     },
//     leading: Icon(icon, color: Colors.blue),
//     title: Text(
//       title,
//       style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//     ),
//     subtitle: Text(subTitle),
//     trailing: Icon(
//       Icons.favorite,
//       color: Colors.red,
//     ),
//   );
// }

// GridView gridView = GridView.count(
//     crossAxisCount: 2,
//     mainAxisSpacing: 10,
//     crossAxisSpacing: 10,
//     children: _buildGridTileList(15),
// );

// List<Container> _buildGridTileList(int count) {
//   return List.generate(
//     count,
//     (i) {
//       return Container(
//         child: Image.asset(
//           'assets/images/${i + 1}.jpeg',
//           fit: BoxFit.cover,
//         ),
//       );
//     },
//   );
// }

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Flutter Layout Demo",
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Layout Demo'),
//         ),
//         body: ListView(
//           children: <Widget>[
//             Image.asset(
//               'assets/images/lake.jpg',
//               width: 600,
//               height: 240,
//               fit: BoxFit.cover,
//             ),
//             _titleSection,
//             _buttonSection,
//             _textSection,
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _titleSection = Container(
//   padding: const EdgeInsets.all(32),
//   child: Row(
//     children: <Widget>[
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Text(
//                 'Oeschinen Lake Campground',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             Text(
//               'Kandersteg, Switzerland',
//               style: TextStyle(color: Colors.grey[500]),
//             ),
//           ],
//         ),
//       ),
//       FavoriteWidget(),
//     ],
//   ),
// );

// Widget _buttonSection = Container(
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: <Widget>[
//       _buildButtonColumn(Icons.phone, 'CALL', Colors.blue),
//       _buildButtonColumn(Icons.near_me, 'ROUTE', Colors.blue),
//       _buildButtonColumn(Icons.share, 'SHARE', Colors.blue),
//     ],
//   ),
// );

// Widget _textSection = Container(
//   padding: const EdgeInsets.all(32),
//   child: Text(
//     'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
//     'Alps. Situated 1,578 meters above sea level, it is one of the '
//     'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
//     'half-hour walk through pastures and pine forest, leads you to the '
//     'lake, which warms to 20 degrees Celsius in the summer. Activities '
//     'enjoyed here include rowing, and riding the summer toboggan run.',
//     softWrap: true,
//     style: TextStyle(fontSize: 14, height: 1.5),
//   ),
// );

// Widget _buildButtonColumn(IconData icon, String label, Color color) {
//   return Column(
//     children: <Widget>[
//       Icon(
//         icon,
//         color: color,
//       ),
//       Container(
//         margin: const EdgeInsets.only(top: 8),
//         child: Text(
//           label,
//           style: TextStyle(
//               fontSize: 12, fontWeight: FontWeight.w400, color: color),
//         ),
//       ),
//     ],
//   );
// }

// class FavoriteWidget extends StatefulWidget {
//   @override
//   _FavoriteWidgetState createState() => _FavoriteWidgetState();
// }

// class _FavoriteWidgetState extends State<FavoriteWidget> {
//   bool _isFavorited = true;
//   int _favoriteCount = 41;

//   _toggleFavorite() {
//     setState(() {
//       if (_isFavorited) {
//         _isFavorited = false;
//         _favoriteCount--;
//       } else {
//         _isFavorited = true;
//         _favoriteCount++;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(0),
//           child: IconButton(
//             icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
//             color: Colors.red[500],
//             onPressed: _toggleFavorite,
//           ),
//         ),
//         SizedBox(
//           width: 18,
//           child: Container(
//             child: Text('$_favoriteCount'),
//           ),
//         ),
//       ],
//     );
//   }
// }
