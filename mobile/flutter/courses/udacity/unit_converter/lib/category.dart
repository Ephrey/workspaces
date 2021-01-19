// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering

import 'package:flutter/material.dart';
import 'package:unit_converter/unit.dart';
import 'package:unit_converter/converter_route.dart';

const double _containerHeigh = 100.0;
const double _containerPadding = 8.0;
const double _borderRadius = _containerHeigh / 2.0;
const double _iconSize = 60.0;
const double _iconPadding = 16.0;

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData icon;
  final List<Unit> units;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: You'll need the name, color, and iconLocation from main.dart
  const Category({
    Key key,
    this.name,
    this.color,
    this.icon,
    this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(icon != null),
        super(key: key);

  void _navigateToConverter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ConverterRoute(
            name: this.name,
            color: this.color,
            units: this.units,
          );
        },
      ),
    );
  }

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
        child: InkWell(
          borderRadius: BorderRadius.circular(_borderRadius),
          splashColor: color['splash'],
          highlightColor: color['highlight'],
          onTap: () => _navigateToConverter(context),
          child: Padding(
            padding: const EdgeInsets.all(_containerPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(_iconPadding),
                  child: Icon(icon, size: _iconSize),
                ),
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
