import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/widgets/buttons/plus_button_view.dart';
import 'package:maket/ui/widgets/item_tile.dart';
import 'package:maket/ui/widgets/list/list_more_info.dart';
import 'package:maket/ui/widgets/list/list_name.dart';
import 'package:maket/ui/widgets/list/list_subtitle.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

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
              Container(
                color: kPrimaryColor,
                child: PaddingView(
                  vertical:
                      Numbers.size(context: context, percent: Numbers.three),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NavBar(color: kTextPrimaryColor),
                      ListName(
                        name: 'Visitor meal after my Parent ...',
                        color: kTextPrimaryColor,
                        fontSize: 35.0,
                      ),
                      Separator(distanceAsPercent: Numbers.two),
                      ListSubTitle(
                        text:
                            'Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.',
                        fontSize: 17.0,
                      ),
                      Separator(distanceAsPercent: Numbers.two),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ExpandedView(child: ListMoreInfo()),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                'Spent',
                                style: TextStyle(
                                  color: kTextSecondaryColor,
                                ),
                              ),
                              Separator(
                                dimension: Dimension.width,
                                distanceAsPercent: Numbers.one,
                              ),
                              Text(
                                'R1.500,00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kBgPrimaryColor,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ExpandedView(
                child: PaddingView(
                  child: ListView(
                    children: [
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                      ItemTitle(
                        item: {
                          'id': '1',
                          'name': 'Spinach',
                          'Category': 'cat',
                        },
                        onItemTap: () => print('item tapped ...'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          PlusButton(),
        ],
      ),
    );
  }
}
