import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/item_tile.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/numbers.dart';

class CreateShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PageView(
        children: [
          PaddingView(
            child: _SetShoppingListNameAndDescriptionViewBody(),
          ),
          PaddingView(
            child: _AddItemsToShoppingListView(),
          )
        ],
      ),
    );
  }
}

class _SetShoppingListNameAndDescriptionViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NavBar(), _SetShoppingListNameAndDescriptionForm()],
    );
  }
}

class _SetShoppingListNameAndDescriptionForm extends StatelessWidget {
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
        _SetListNameAndDescriptionActionButton(),
      ],
    );

    return ExpandedView(
      child: CenteredView(child: ScrollableView(child: _form)),
    );
  }
}

class _SetListNameAndDescriptionActionButton extends StatelessWidget {
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

class _AddItemsToShoppingListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchView(),
        Separator(distanceAsPercent: Numbers.two),
        _ItemsList(),
        Separator(distanceAsPercent: Numbers.three),
        _AddItemsToListActionButton(),
        Separator(distanceAsPercent: Numbers.two),
      ],
    );
  }
}

class _ItemsList extends StatelessWidget {
  void onItemTap(String itemId) {
    print('item $itemId click');
  }

  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: ListView.separated(
        addAutomaticKeepAlives: false,
        itemCount: Item.groupByCategory().length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return ItemTitle(
            item: Item.groupByCategory()[itemIndex],
            onItemTap: onItemTap,
          );
        },
        separatorBuilder: (_, __) => Separator(distanceAsPercent: Numbers.one),
      ),
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
