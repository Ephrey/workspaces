import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/list/list_items.dart';
import 'package:maket/ui/widgets/loading.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/search_view.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';

class CreateShoppingListView extends StatefulWidget {
  @override
  _CreateShoppingListViewState createState() => _CreateShoppingListViewState();
}

class _CreateShoppingListViewState extends State<CreateShoppingListView> {
  static const Duration _duration = const Duration(milliseconds: 500);
  static const Curve _curve = Curves.ease;

  PageController _pageController;
  int _initialPage = Numbers.zero;

  TextEditingController _nameController;
  TextEditingController _descriptionController;
  dynamic _shoppingListItems = [];

  List<Map<String, dynamic>> _itemsOnAddItemsToListView = [];

  Status _nameState;
  Status _descriptionState;

  bool _canMoveToSetItem = false;

  dynamic _handleNameField(String name) {
    final int _nameLength = name.length;

    final bool _isNameValid = (_nameLength >= Forms.listNameMinLength &&
        _nameLength <= Forms.listNameMaxLength);

    if (_isNameValid && (_nameState == Status.success)) return false;

    _setState(() => _nameState = _getFieldState(_isNameValid));
    _checkIfCanGoToSetItems();
  }

  dynamic _handleDescriptionField(String description) {
    final int _descriptionLength = description.length;

    final bool _isDescriptionValid =
        (_descriptionLength >= Forms.listDescriptionMinLength &&
            _descriptionLength <= Forms.listDescriptionMaxLength);

    if (_isDescriptionValid && (_descriptionState == Status.success))
      return false;

    _setState(() => _descriptionState = _getFieldState(_isDescriptionValid));
  }

  void _checkIfCanGoToSetItems() {
    _setState(() => _canMoveToSetItem = (_nameState == Status.success));
  }

  Status _getFieldState(bool state) => (state) ? Status.success : Status.error;

  void _moveToAddItemsToList() {
    _pageController.nextPage(duration: _duration, curve: _curve);
  }

  void _moveBackToSetListNameAndDescription() {
    _pageController.previousPage(duration: _duration, curve: _curve);
  }

  Future<void> _getItems() async {
    final _items = await locator<ItemViewModel>().getGroupedByCategory();
    _setState(() => _itemsOnAddItemsToListView = _items);
  }

  void _handlePageChange(int currentPageIndex) {
    if (currentPageIndex == Numbers.one &&
        _itemsOnAddItemsToListView.length == Numbers.zero) {
      _getItems();
    }
  }

  void addItemToShoppingList(Map<String, dynamic> item) {
    final _shoppingListItem =
        ItemModel.fromJsonListItem(json: item).toJsonListItem();

    _setState(() {
      item['select'] = true;
      print(item);
      // _itemsOnAddItemsToListView[(_itemsOnAddItemsToListView.indexOf(item))] =
      //     item;
    });
  }

  void _setState(Function callback) => setState(callback);

  @override
  void initState() {
    _pageController = PageController(initialPage: _initialPage);
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _itemsOnAddItemsToListView.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      child: PageView(
        controller: _pageController,
        onPageChanged: _handlePageChange,
        physics: NeverScrollableScrollPhysics(),
        children: [
          PaddingView(
            child: _SetShoppingListNameAndDescriptionViewBody(
              nameController: _nameController,
              descriptionController: _descriptionController,
              handleNameField: _handleNameField,
              handleDescriptionField: _handleDescriptionField,
              next: _moveToAddItemsToList,
              nameState: _nameState,
              descriptionState: _descriptionState,
              canMoveToSetItem: _canMoveToSetItem,
            ),
          ),
          PaddingView(
            child: _AddItemsToShoppingListView(
              prev: _moveBackToSetListNameAndDescription,
              items: _itemsOnAddItemsToListView,
              onItemTap: addItemToShoppingList,
            ),
          )
        ],
      ),
    );
  }
}

class _SetShoppingListNameAndDescriptionViewBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function handleNameField;
  final Function handleDescriptionField;
  final Status nameState;
  final Status descriptionState;
  final Function next;
  final bool canMoveToSetItem;

  _SetShoppingListNameAndDescriptionViewBody({
    this.nameController,
    this.descriptionController,
    this.handleNameField,
    this.handleDescriptionField,
    this.nameState,
    this.descriptionState,
    this.next,
    this.canMoveToSetItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(),
        _SetShoppingListNameAndDescriptionForm(
          nameController: nameController,
          descriptionController: descriptionController,
          handleNameField: handleNameField,
          handleDescriptionField: handleDescriptionField,
          nameState: nameState,
          descriptionState: descriptionState,
          next: next,
          canMoveToSetItem: canMoveToSetItem,
        )
      ],
    );
  }
}

class _SetShoppingListNameAndDescriptionForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function handleNameField;
  final Function handleDescriptionField;
  final Status nameState;
  final Status descriptionState;
  final Function next;
  final bool canMoveToSetItem;

  _SetShoppingListNameAndDescriptionForm({
    this.nameController,
    this.descriptionController,
    this.handleNameField,
    this.handleDescriptionField,
    this.nameState,
    this.descriptionState,
    this.next,
    this.canMoveToSetItem,
  });

  @override
  Widget build(BuildContext context) {
    Widget _form = Column(
      children: [
        FormInput(
          label: 'List Name',
          controller: nameController,
          onChange: handleNameField,
          state: nameState,
          autoFocus: true,
        ),
        Separator(),
        FormInput(
          controller: descriptionController,
          inputType: InputType.textArea,
          label: 'List Description',
          hintText: 'Type in the description (optional)',
          keyBorderType: TextInputType.multiline,
          minLines: Numbers.four,
          capitalization: TextCapitalization.sentences,
          onChange: handleDescriptionField,
          state: descriptionState,
        ),
        Separator(),
        _SetListNameAndDescriptionActionButton(
          next: next,
          canMoveToSetItem: canMoveToSetItem,
        ),
      ],
    );

    return ExpandedView(
      child: CenteredView(child: ScrollableView(child: _form)),
    );
  }
}

class _SetListNameAndDescriptionActionButton extends StatelessWidget {
  final Function next;
  final bool canMoveToSetItem;

  _SetListNameAndDescriptionActionButton({this.next, this.canMoveToSetItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: "Done",
            contentPosition: Position.center,
            disabled: !canMoveToSetItem,
            onPressed: () => print('Done! Creating list ...'),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType:
                (canMoveToSetItem) ? ButtonType.primary : ButtonType.disable,
            text: "Add Items",
            icon: Icons.keyboard_arrow_right,
            iconPosition: Position.right,
            contentPosition: Position.center,
            onPressed: next,
          ),
        ),
      ],
    );
  }
}

class _AddItemsToShoppingListView extends StatelessWidget {
  final Function prev;
  final List<Map<String, dynamic>> items;
  final Function onItemTap;

  _AddItemsToShoppingListView({this.prev, this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchView(),
        Separator(distanceAsPercent: Numbers.two),
        _ItemsList(items: items, onItemTap: onItemTap),
        Separator(distanceAsPercent: Numbers.three),
        _AddItemsToListActionButton(prev: prev),
        Separator(distanceAsPercent: Numbers.two),
      ],
    );
  }
}

class _ItemsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function onItemTap;

  _ItemsList({this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ExpandedView(
      child: (items.length == Numbers.zero)
          ? Loading()
          : ListItems(items: items, onItemTaped: onItemTap),
    );
  }
}

class _AddItemsToListActionButton extends StatelessWidget {
  final Function prev;
  _AddItemsToListActionButton({this.prev});

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
            onPressed: prev,
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
