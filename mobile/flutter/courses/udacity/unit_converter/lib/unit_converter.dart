// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'api.dart';
import 'category.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class UnitConverter extends StatefulWidget {
  /// Color for this [Category].
  final Category category;

  /// This [ConverterRoute] requires the color and units to not be null.
  const UnitConverter({
    @required this.category,
  }) : assert(category != null);

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  // TODO: Set some variables, such as for keeping track of the user's input value and units
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidateError = false;
  final _inputKey = GlobalKey(debugLabel: 'inputText');
  bool _showErrorUI = false;

  // TODO: Determine whether you need to override anything, such as initState()
  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(UnitConverter old) {
    super.didUpdateWidget(old);

    if (old.category != widget.category) {
      _createDropdownMenuItems();
      _setDefaults();
    }
  }

  // TODO: Add other helper functions. We've given you one, _format()
  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];

    for (var unit in widget.category.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  void _setDefaults() {
    setState(() {
      setState(() {
        _fromValue = widget.category.units[0];
        _toValue = widget.category.units[1];
      });
    });
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  Future<void> _updateConversion() async {
    if (widget.category.name == apiCategory['name']) {
      final api = Api();
      final conversion = await api.convert(
        apiCategory['route'],
        _fromValue.name,
        _toValue.name,
        _inputValue.toString(),
      );

      if (conversion != null) {
        setState(() {
          _showErrorUI = false;
          _convertedValue = _format(conversion);
        });
      } else {
        _showErrorUI = true;
      }
    } else {
      setState(() {
        _convertedValue = _format(
            _inputValue * (_toValue.conversion / _fromValue.conversion));
      });
    }
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _showValidateError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error $e');
          _showValidateError = true;
        }
      }
    });
  }

  Unit _getUnit(String unitName) {
    return widget.category.units.firstWhere((Unit unit) {
      return unit.name == unitName;
    }, orElse: null);
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
                value: currentValue,
                items: _unitMenuItems,
                onChanged: onChanged,
                style: Theme.of(context).textTheme.headline6),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category.units == null ||
        (widget.category.name == apiCategory['name'] && _showErrorUI)) {
      return SingleChildScrollView(
        child: Container(
          margin: _padding,
          padding: _padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: widget.category.color['error'],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 180.0,
                color: Colors.white,
              ),
              Text(
                "Oh no! We can't connect right now.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    final _inputGroup = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            key: _inputKey,
            style: Theme.of(context).textTheme.headline4,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Input',
              labelStyle: Theme.of(context).textTheme.headline4,
              errorText: _showValidateError ? 'Invalid number entered' : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConversion),
        ],
      ),
    );

    // TODO: Create a compare arrows icon.
    final _arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    // TODO: Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].
    final _outputGroup = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.headline4,
            ),
            decoration: InputDecoration(
              labelText: 'Ouput',
              labelStyle: Theme.of(context).textTheme.headline4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_toValue.name, _updateToConversion)
        ],
      ),
    );

    final _converter = ListView(
      children: [
        _inputGroup,
        _arrows,
        _outputGroup,
      ],
    );

    return Padding(
      padding: _padding,
      child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return _converter;
        } else {
          return Center(
            child: Container(
              width: 450.0,
              child: _converter,
            ),
          );
        }
      }),
    );
  }
}
