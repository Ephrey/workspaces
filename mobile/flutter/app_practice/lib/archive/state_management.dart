import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Tuto",
      home: Scaffold(
        appBar: AppBar(
          title: Text('RENDER STATS'),
        ),
        body: Center(
          child: Text('I am at center :)'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.plus_one,
          ),
          onPressed: () => print(
            'Button pressed :)',
          ),
        ),
      ),
    );
  }
}

// class ParentWidget extends StatefulWidget {
//   @override
//   _ParentWidgetState createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {
//   bool _active = false;

//   void _handleTapBoxChanged(bool newValue) {
//     setState(() {
//       _active = newValue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TapBoxC(
//         active: _active,
//         onChanged: _handleTapBoxChanged,
//       ),
//     );
//   }
// }

// class TapBoxC extends StatefulWidget {
//   TapBoxC({Key key, this.active: false, @required this.onChanged})
//       : super(key: key);

//   final bool active;
//   final ValueChanged<bool> onChanged;

//   @override
//   _TapBoxCState createState() => _TapBoxCState();
// }

// class _TapBoxCState extends State<TapBoxC> {
//   bool _highlight = false;

//   void _handleTapDown(TapDownDetails details) {
//     setState(() {
//       _highlight = true;
//     });
//   }

//   void _handleTapUp(TapUpDetails details) {
//     setState(() {
//       _highlight = false;
//     });
//   }

//   void _handleTapCancel() {
//     setState(() {
//       _highlight = false;
//     });
//   }

//   void _handleTap() {
//     widget.onChanged(!widget.active);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _handleTapDown,
//       onTapUp: _handleTapUp,
//       onTap: _handleTap,
//       onTapCancel: _handleTapCancel,
//       child: Container(
//         child: Center(
//           child: Text(
//             widget.active ? 'Active' : 'Inactive',
//             style: TextStyle(
//               fontSize: 32.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         width: 200.0,
//         height: 200.0,
//         decoration: BoxDecoration(
//           color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
//           border: _highlight
//               ? Border.all(color: Colors.teal[700], width: 10.0)
//               : null,
//         ),
//       ),
//     );
//   }
// }

// class ParentWidget extends StatefulWidget {
//   @override
//   _ParentWidgetState createState() => _ParentWidgetState();
// }

// class _ParentWidgetState extends State<ParentWidget> {
//   bool _active = false;

//   void _handleTapBoxChanged(bool newValue) {
//     setState(() {
//       _active = newValue;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TapBoxB(
//         active: _active,
//         onChange: _handleTapBoxChanged,
//       ),
//     );
//   }
// }

// class TapBoxB extends StatelessWidget {
//   TapBoxB({Key key, this.active: false, @required this.onChange})
//       : super(key: key);

//   final bool active;
//   final ValueChanged<bool> onChange;

//   void _handleTap() {
//     onChange(!active);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         width: 200,
//         height: 200,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: active ? Colors.lightGreen[700] : Colors.grey[600],
//           border: Border.all(width: 20, color: Colors.grey[200]),
//         ),
//         child: Center(
//           child: Text(
//             active ? 'Active' : 'Inactive',
//             style: TextStyle(
//               fontSize: 28,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//       onTap: _handleTap,
//     );
//   }
// }

// // THE WIDGET MANAGE TI OWN STATE
// class TapBoxA extends StatefulWidget {
//   @override
//   _TapBoxAState createState() => _TapBoxAState();
// }

// class _TapBoxAState extends State<TapBoxA> {
//   bool _active = false;

//   void _handleTap() {
//     setState(() {
//       _active = !_active;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         width: 200.0,
//         height: 200.0,
//         padding: EdgeInsets.all(20),
//         child: Center(
//           child: Text(
//             _active ? 'Active' : 'Inactive',
//             style: TextStyle(
//               fontSize: 32.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         decoration: BoxDecoration(
//           color: _active ? Colors.lightGreen[700] : Colors.grey[600],
//           border: Border.all(
//             width: 15,
//             color: Colors.grey[200],
//           ),
//         ),
//       ),
//       onTap: _handleTap,
//     );
//   }
// }
