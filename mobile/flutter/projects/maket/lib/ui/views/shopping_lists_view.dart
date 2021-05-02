import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/ui/views/base/aligned_view.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/buttons/circle_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/fields/form_select.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/math.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class ShoppingListsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(child: _ShoppingListsViewBody());
  }
}

class _ShoppingListsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize _screenSize = ScreenSize(context: context);
    double _screenWidth = _screenSize.width;
    double _screenHeight = _screenSize.height;

    return PaddingView(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: PaddingView(
              vertical:
                  Math.percentage(percent: Numbers.six, total: _screenWidth),
              child: CircleButton(
                icon: Icons.add,
                iconColor: kTextPrimaryColor,
                buttonSize: Math.percentage(
                    percent: Numbers.seventeen, total: _screenWidth),
                backgroundColor: kPrimaryColor,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: Math.percentage(
                            percent: Numbers.fifty, total: _screenHeight),
                        margin: EdgeInsets.all((Math.percentage(
                                percent: Numbers.four, total: _screenWidth) -
                            Numbers.two)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Math.percentage(
                                percent: Numbers.four, total: _screenWidth),
                          ),
                          color: Colors.white,
                        ),
                        child: PaddingView(
                          child: CenteredView(
                            child: ScrollableView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AlignedView(
                                    position: Alignment.centerLeft,
                                    child: Text(
                                      'Create an Item',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Separator(),
                                  FormInput(label: 'Item Name'),
                                  Separator(),
                                  FormSelect(
                                      label: 'Item Category', password: true),
                                  Separator(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ActionButton(
                                          buttonType: ButtonType.secondary,
                                          text: 'Back',
                                          icon: Icons.keyboard_arrow_left,
                                          contentPosition: Position.center,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            print('Back');
                                          },
                                        ),
                                      ),
                                      Separator(dimension: Dimension.width),
                                      Expanded(
                                        child: ActionButton(
                                          buttonType: ButtonType.primary,
                                          text: 'Done',
                                          contentPosition: Position.center,
                                          onPressed: () => print('Done'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Shopping Lists will \n appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Math.percentage(
                      percent: Numbers.six, total: _screenWidth),
                  fontWeight: FontWeight.w800,
                  color: kTextSecondaryColor,
                ),
              ),
              Separator(
                dimension: Dimension.height,
                distanceAsPercent: Numbers.three,
              ),
              Text(
                'To create Lists and Items, click on the + button.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (Math.percentage(
                          percent: Numbers.five, total: _screenWidth) -
                      Numbers.two),
                  fontWeight: FontWeight.w800,
                  color: kTextSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*

showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: Math.percentage(
                            percent: Numbers.thirty, total: _screenHeight),
                        margin: EdgeInsets.all((Math.percentage(
                                percent: Numbers.four, total: _screenWidth) -
                            Numbers.two)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Math.percentage(
                                percent: Numbers.four, total: _screenWidth),
                          ),
                          color: Colors.white,
                        ),
                        child: PaddingView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionButton(
                                buttonType: ButtonType.primary,
                                text: 'Create a List',
                                contentPosition: Position.center,
                                onPressed: () => print('Create a List'),
                              ),
                              Separator(),
                              ActionButton(
                                buttonType: ButtonType.secondary,
                                text: 'Create an Item',
                                contentPosition: Position.center,
                                onPressed: () => print('Create an Item'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
 */
