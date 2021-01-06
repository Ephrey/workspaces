// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering

import 'package:flutter/material.dart';

const double _containerHeigh = 100.0;
const double _containerPadding = 8.0;
const double _borderRadius = _containerHeigh / 2.0;
const double _iconSize = 60.0;
const double _iconPadding = 16.0;
const double _textSize = 24.0;
const double _iconWithColoredBgWidth = 70.0;

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: You'll need the name, color, and iconLocation from main.dart
  const Category({Key key, this.name, this.color, this.icon}) : super(key: key);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    // TODO: Build the custom widget here, referring to the Specs.
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _containerHeigh,
        padding: const EdgeInsets.all(_containerPadding),
        child: InkWell(
          borderRadius: BorderRadius.circular(_borderRadius),
          splashColor: color,
          highlightColor: color,
          onTap: () => print('I was tapped !'),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(_iconPadding),
                child: Icon(icon, size: _iconSize),
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(fontSize: _textSize),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
