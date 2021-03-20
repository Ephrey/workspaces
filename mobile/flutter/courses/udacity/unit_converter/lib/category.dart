// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering

import 'package:flutter/material.dart';
import 'package:unit_converter/unit.dart';

// A [Category] keeps track of a list of [Unit]s.
class Category {
  final String name;
  final ColorSwatch color;
  final String iconLocation;
  final List<Unit> units;

  const Category(
      {@required this.name,
      @required this.color,
      @required this.iconLocation,
      @required this.units})
      : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null);
}
