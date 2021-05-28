import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/set_item_price_view.dart';
import 'package:maket/ui/widgets/buttons/plus_button_view.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/on_long_press_actions.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/show_modal.dart';
import 'package:maket/utils/snackbar/hide_snackbar.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';

class ShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      withSafeArea: false,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ShoppingListInfoBlock(),
              _ShoppingListItems(),
              Separator(),
            ],
          ),
          PlusButton(),
        ],
      ),
    );
  }
}

class _ShoppingListInfoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: PaddingView(
        vertical: Numbers.size(context: context, percent: Numbers.three),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NavBar(color: kTextPrimaryColor),
            ListName(
              name: 'Visitor meal after my Parent...',
              color: kTextPrimaryColor,
              fontSize: (Numbers.size(context: context, percent: Numbers.four) -
                  Numbers.two),
            ),
            Separator(distanceAsPercent: Numbers.two),
            ListSubTitle(
              text: 'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.',
              fontSize: Numbers.size(context: context, percent: Numbers.two) -
                  Numbers.three,
            ),
            Separator(distanceAsPercent: Numbers.two),
            _ShoppingListMoreInfo(),
          ],
        ),
      ),
    );
  }
}

class _ShoppingListMoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ExpandedView(
          child: ListItemCountAndCreateDate(
            fontSize: Numbers.size(context: context, percent: Numbers.two) -
                Numbers.four,
          ),
        ),
        _Spent(),
      ],
    );
  }
}

class _Spent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _spentAmountStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: kBgPrimaryColor,
      fontSize:
          (Numbers.size(context: context, percent: Numbers.two) - Numbers.two),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Text('Spent', style: TextStyle(color: kTextSecondaryColor)),
        Separator(
          dimension: Dimension.width,
          distanceAsPercent: Numbers.one,
        ),
        Text('R1.500,00', style: _spentAmountStyle),
      ],
    );
  }
}

class _ShoppingListItems extends StatelessWidget {
  void _handleItemTap(BuildContext context, item) {
    showModel(
      context: context,
      child: SetItemPriceView(item: item),
    );
  }

  void _handleItemLongPress(BuildContext context, item) {
    showSnackBar(
      context: context,
      content: OnLongPressActions(
        onCancel: () => hideSnackBar(context: context),
      ),
      duration: kOneYearDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: PaddingView(
        child: ListItems(
          items: [], // Item.groupByCategory(),
          onItemTaped: (item) => _handleItemTap(context, item),
          onItemLongPress: (item) => _handleItemLongPress(context, item),
        ),
      ),
    );
  }
}
