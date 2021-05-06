import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class CreateShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PageView(
        children: [
          PaddingView(
            child: _CreateShoppingListViewBody(),
          ),
          PaddingView(
            child: _AddItemToShoppingListView(),
          )
        ],
      ),
    );
  }
}

class _AddItemToShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormInput(hintText: 'Search for an Item', prefixIcon: Icons.search),
        Separator(distanceAsPercent: Numbers.two),
        ExpandedView(
          child: ListView.separated(
            addAutomaticKeepAlives: false,
            itemCount: Item.groupByCategory().length,
            itemBuilder: (BuildContext context, int i) {
              final item = Item.groupByCategory()[i];
              return ListTile(
                tileColor: (item['type'] == null) ? kSecondaryColor : null,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: (item['type'] == null) ? 25.0 : 15.0,
                ),
                title: Text(
                  '${item['name']}',
                  style: TextStyle(
                    color: (item['type'] == null)
                        ? kPrimaryColor
                        : kTextSecondaryColor,
                    fontSize: 17.0,
                    fontWeight: (item['type'] == null)
                        ? FontWeight.w400
                        : FontWeight.w900,
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) =>
                Separator(distanceAsPercent: Numbers.one),
          ),
        ),
        Separator(distanceAsPercent: Numbers.three),
        _AddItemsToListActionButton(),
        Separator(distanceAsPercent: Numbers.two),
      ],
    );
  }
}

class _CreateShoppingListViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NavBar(), _CreateShoppingListForm()],
    );
  }
}

class _CreateShoppingListForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _form = Column(
      children: [
        FormInput(label: 'List Name'),
        Separator(),
        FormInput(
          inputType: InputType.textArea,
          label: 'List Description',
          hintText: 'Type in the description (optional)',
          keyBorderType: TextInputType.multiline,
          minLines: Numbers.four,
        ),
        Separator(),
        _ActionButton(),
      ],
    );

    return ExpandedView(
      child: CenteredView(child: ScrollableView(child: _form)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: "Done",
            contentPosition: Position.center,
            disabled: true,
            onPressed: () => print('Done creating list ...'),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.disable,
            text: "Next",
            icon: Icons.keyboard_arrow_right,
            iconPosition: Position.right,
            contentPosition: Position.center,
            onPressed: () => print('Done creating list ...'),
          ),
        ),
      ],
    );
  }
}

class _AddItemsToListActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: "Back",
            icon: Icons.keyboard_arrow_left,
            contentPosition: Position.center,
            onPressed: () =>
                print('Go back to set List name and description ...'),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.disable,
            text: "Done",
            contentPosition: Position.center,
            onPressed: () => print('Done ! Save List'),
          ),
        ),
      ],
    );
  }
}
