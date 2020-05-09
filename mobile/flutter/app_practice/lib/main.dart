import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Tuto",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Route Returned Value'),
        ),
        body: HomePage(),
      ),
      // MyPage(
      //   title: 'Home Page',
      //   where: 'a',
      // ),
      // routes: <String, WidgetBuilder>{
      //   '/a': (BuildContext context) => MyPage(
      //         title: 'Page A',
      //         where: 'b',
      //         theme: Colors.lightGreen,
      //       ),
      //   '/b': (BuildContext context) => MyPage(
      //         title: 'Page B',
      //         where: 'c',
      //         theme: Colors.grey,
      //       ),
      //   '/c': (BuildContext context) => MyPage(
      //         title: 'Page C',
      //         where: '',
      //         theme: Colors.red[200],
      //       ),
      // },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text('God to page 2'),
        onPressed: () async {
          bool value = await Navigator.of(context).push(
            MaterialPageRoute<bool>(builder: (BuildContext context) {
              return PageTwo();
            }),
          );

          final message = (value) ? "User agreed :)" : "User disagreed :(";

          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
        },
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation Page'),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Are you sure ?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.lightGreen),
                    child: Text('Yes !'),
                  ),
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text('NO !'),
                  ),
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text('Learn More'),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MyPopUpRoute(
                        builder: (BuildContext context) {
                          return Model();
                        },
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Model extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: GestureDetector(
          child: Text(
            'Hello, model',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class MyPopUpRoute extends PopupRoute {
  MyPopUpRoute({RouteSettings settings, @required this.builder})
      : super(settings: settings);

  WidgetBuilder builder;

  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.white70;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => 'Close Model';

  @override
  Widget buildPage(BuildContext context, _, __) {
    return builder(context);
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

// class MyPage extends StatelessWidget {
//   MyPage(
//       {Key key,
//       @required this.title,
//       @required this.where,
//       @required this.theme})
//       : super(key: key);

//   final String title;
//   final String where;
//   final Color theme;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: theme,
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           FlatButton(
//             child: Text('Go to Page ${where.toUpperCase()}'),
//             onPressed: () {
//               Navigator.pushNamed(context, '/$where');
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }
