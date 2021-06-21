import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:provider/provider.dart';

class OnLongPressActions extends StatelessWidget {
  final Function onCancel;
  final Function selectAllList;
  final Function onDelete;

  OnLongPressActions({this.onCancel, this.selectAllList, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>.value(
      value: locator<ShoppingListViewModel>(),
      child: PaddingView(
        vertical: Numbers.asDouble(Numbers.three),
        child: Consumer<ShoppingListViewModel>(
          builder: (_, viewModel, child) {
            final int _counter = viewModel.selectedElementsCounter;
            final bool _hasSelectedList = (_counter > Numbers.zero);

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (child != null) child,
                if (_hasSelectedList) _Text(text: '$_counter'),
                _ActionButtons(
                  selectAllList: selectAllList,
                  onDelete: onDelete,
                  hasSelectedList: _hasSelectedList,
                ),
              ],
            );
          },
          child: GestureHandler(child: _Text(text: 'Cancel'), onTap: onCancel),
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final String text;
  final Function onTap;

  _Text({@required this.text, this.onTap}) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    double _fontSize = (Numbers.size(context: context, percent: Numbers.two));

    TextStyle _style = TextStyle(
      fontSize: _fontSize,
      fontWeight: FontWeight.w600,
    );

    return GestureHandler(child: Text('$text', style: _style), onTap: onTap);
  }
}

class _ActionButtons extends StatelessWidget {
  final Function selectAllList;
  final Function onDelete;
  final bool hasSelectedList;

  _ActionButtons({
    this.selectAllList,
    this.onDelete,
    this.hasSelectedList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasSelectedList)
          GestureHandler(
            child: _Icon(icon: FontAwesomeIcons.trashAlt),
            onTap: onDelete,
          ),
        if (hasSelectedList)
          Separator(
            dimension: Dimension.width,
            distanceAsPercent: Numbers.eight,
          ),
        GestureHandler(
          child: _Icon(
              icon: (context.watch<ShoppingListViewModel>().isAllSelected)
                  ? FontAwesomeIcons.solidCheckSquare
                  : FontAwesomeIcons.checkSquare),
          onTap: selectAllList,
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final IconData icon;
  const _Icon({@required this.icon}) : assert(icon != null);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: kTextPrimaryColor,
      size: (Numbers.size(
        context: context,
        percent: Numbers.six,
        dimension: Dimension.width,
      )),
    );
  }
}
