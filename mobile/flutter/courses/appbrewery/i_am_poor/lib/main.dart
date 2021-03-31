import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.teal[100],
          appBar: AppBar(
            title: Text('I am Poor'),
            backgroundColor: Colors.teal,
          ),
          body: Center(
            child: Image(image: AssetImage('assets/images/stone.jpg')),
          ),
        ),
      ),
    );
