import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/common.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/base_view.dart';
import 'package:maket/ui/views/base/centered_view.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/padding_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/widgets/add_item_to_shopping_list.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/nav_bar.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/hide_keyboard.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

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
  TextEditingController _budgetController;
  TextEditingController _descriptionController;

  Status _nameState;
  Status _budgetState;
  Status _descriptionState;

  bool _canCreateList = false;
  bool _hasItems = false;

  dynamic _handleNameField(String name) {
    final int _nameLength = name.length;

    if (_nameLength > Forms.listNameMaxLength) {
      _nameController.text = name.substring(
        Numbers.zero,
        Forms.listNameMaxLength,
      );
      return false;
    }

    final bool _isNameValid = (_nameLength >= Forms.listNameMinLength &&
        _nameLength <= Forms.listNameMaxLength);

    if (_isNameValid && (_nameState == Status.success)) return false;

    _setState(() => _nameState = _getFieldState(_isNameValid));
    _checkIfCanGoToSetItems();
  }

  dynamic _handleBudgetField(String budget) {
    double _budget = Numbers.toValidDecimal(budget);

    bool _isValidBudget = (_budget > Forms.minBudget);

    if (_isValidBudget && (_budgetState == Status.success)) return false;

    if (_isValidBudget) {
      _setState(() => _budgetState = Status.success);
    } else {
      _setState(() => _budgetState = Status.error);
    }
  }

  dynamic _handleDescriptionField(String description) {
    final int _descriptionLength = description.length;

    if (_descriptionLength > Forms.listDescriptionMaxLength) {
      _descriptionController.text = description.substring(
        Numbers.zero,
        Forms.listDescriptionMaxLength,
      );
      return false;
    }

    final bool _isDescriptionValid =
        (_descriptionLength >= Forms.listDescriptionMinLength &&
            _descriptionLength <= Forms.listDescriptionMaxLength);

    if (_isDescriptionValid && (_descriptionState == Status.success))
      return false;

    _setState(() => _descriptionState = _getFieldState(_isDescriptionValid));
  }

  void _checkIfCanGoToSetItems() {
    _setState(() => _canCreateList = (_nameState == Status.success));
  }

  Status _getFieldState(bool state) => (state) ? Status.success : Status.error;

  void _moveToAddItemsToList() {
    hideKeyboard(context: context);
    _pageController.nextPage(duration: _duration, curve: _curve);
  }

  void _moveBackToSetListNameAndDescription() {
    _pageController.previousPage(duration: _duration, curve: _curve);
  }

  Future<void> _getItems() async {
    HttpResponse _response =
        await locator<ItemViewModel>().getAllItemsGroupedByCategories();

    if (_response.status) {
      if (!_notifyIfEmptyItems(_response.data)) {
        _setState(() => _hasItems = _response.status);
      }
    }
  }

  bool _notifyIfEmptyItems(List items) {
    final _hasNoItems = items.length == Numbers.zero;

    if (_hasNoItems) {
      showSnackBar(
        duration: Duration(seconds: Numbers.five),
        flavor: Status.warning,
        context: context,
        content: SnackBarAlert(
          message: kEmptyListItemsWarningMessage,
          textColor: kPrimaryColor,
        ),
      );
    }
    return _hasNoItems;
  }

  Future<void> addItemToShoppingList(ItemModel tappedItem) async {
    await locator<ItemViewModel>()
        .keepSelectedShoppingListItems(tappedItem: tappedItem);
  }

  Future<void> _handleSaveShoppingList({BuildContext context}) async {
    ItemViewModel _itemViewModel = locator<ItemViewModel>();

    final ShoppingListModel _shoppingList = ShoppingListModel(
      name: _nameController.text,
      items: _itemViewModel.selectedShoppingListItems,
      description: _descriptionController.text,
      budget: Numbers.toValidDecimal(_budgetController.text),
    );

    final HttpResponse _response = await context
        .read<ShoppingListViewModel>()
        .create(shoppingList: _shoppingList);

    if (_response.status) {
      pop(context: context);
      await locator<ShoppingListViewModel>().getAllListBodies();
      showSnackBar(
        context: context,
        content: SnackBarAlert(message: _response.message),
        flavor: Status.success,
      );

      _itemViewModel.resetSelectedShoppingListItems();
    } else {
      showSnackBar(
        context: context,
        content: SnackBarAlert(message: _response.message),
        flavor: Status.error,
      );
    }
  }

  void _setState(Function callback) => setState(callback);

  @override
  void initState() {
    _pageController = PageController(initialPage: _initialPage);
    _nameController = TextEditingController();
    _budgetController = TextEditingController();
    _descriptionController = TextEditingController();
    _getItems();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListViewModel>.value(
      value: locator<ShoppingListViewModel>(),
      child: BaseView(
        safeAreaBottom: false,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PaddingView(
              child: _SetShoppingListNameAndDescriptionViewBody(
                nameController: _nameController,
                budgetController: _budgetController,
                descriptionController: _descriptionController,
                handleNameField: _handleNameField,
                handleBudgetField: _handleBudgetField,
                handleDescriptionField: _handleDescriptionField,
                next: _moveToAddItemsToList,
                nameState: _nameState,
                budgetState: _budgetState,
                descriptionState: _descriptionState,
                canMoveToSetItem: _canCreateList,
                hasItems: _hasItems,
                saveShoppingList: _handleSaveShoppingList,
              ),
            ),
            AddItemsToShoppingListView(
              onBackButtonPress: _moveBackToSetListNameAndDescription,
              onItemTap: addItemToShoppingList,
              canSubmit: _canCreateList,
              saveShoppingList: _handleSaveShoppingList,
            )
          ],
        ),
      ),
    );
  }
}

class _SetShoppingListNameAndDescriptionViewBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController budgetController;
  final TextEditingController descriptionController;
  final Function handleNameField;
  final Function handleBudgetField;
  final Function handleDescriptionField;
  final Status nameState;
  final Status budgetState;
  final Status descriptionState;
  final Function next;
  final bool canMoveToSetItem;
  final bool hasItems;
  final Function saveShoppingList;

  _SetShoppingListNameAndDescriptionViewBody({
    this.nameController,
    this.budgetController,
    this.descriptionController,
    this.handleNameField,
    this.handleBudgetField,
    this.handleDescriptionField,
    this.nameState,
    this.budgetState,
    this.descriptionState,
    this.next,
    this.canMoveToSetItem,
    this.hasItems,
    this.saveShoppingList,
  });

  void _onBackArrowTapped() {
    locator<ItemViewModel>().resetSelectedShoppingListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(onTap: _onBackArrowTapped),
        _SetShoppingListNameAndDescriptionForm(
          nameController: nameController,
          budgetController: budgetController,
          descriptionController: descriptionController,
          handleNameField: handleNameField,
          handleBudgetField: handleBudgetField,
          handleDescriptionField: handleDescriptionField,
          nameState: nameState,
          budgetState: budgetState,
          descriptionState: descriptionState,
          next: next,
          canMoveToSetItem: canMoveToSetItem,
          hasItems: hasItems,
          saveShoppingList: saveShoppingList,
        )
      ],
    );
  }
}

class _SetShoppingListNameAndDescriptionForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController budgetController;
  final TextEditingController descriptionController;
  final Function handleNameField;
  final Function handleBudgetField;
  final Function handleDescriptionField;
  final Status nameState;
  final Status budgetState;
  final Status descriptionState;
  final Function next;
  final bool canMoveToSetItem;
  final bool hasItems;
  final Function saveShoppingList;

  _SetShoppingListNameAndDescriptionForm({
    this.nameController,
    this.budgetController,
    this.descriptionController,
    this.handleNameField,
    this.handleBudgetField,
    this.handleDescriptionField,
    this.nameState,
    this.budgetState,
    this.descriptionState,
    this.next,
    this.canMoveToSetItem,
    this.hasItems,
    this.saveShoppingList,
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
          label: 'Your Budget',
          hintText: 'Type in your Budget (optional)',
          controller: budgetController,
          onChange: handleBudgetField,
          state: budgetState,
          keyBorderType: TextInputType.numberWithOptions(decimal: true),
        ),
        Separator(),
        FormInput(
          controller: descriptionController,
          inputType: InputType.textArea,
          label: 'List Description',
          hintText: 'Type in the Description (optional)',
          keyBorderType: TextInputType.multiline,
          minLines: Numbers.one,
          capitalization: TextCapitalization.sentences,
          onChange: handleDescriptionField,
          state: descriptionState,
        ),
        Separator(),
        _SetListNameAndDescriptionActionButton(
          next: next,
          canMoveToSetItem: canMoveToSetItem,
          hasItems: hasItems,
          saveShoppingList: saveShoppingList,
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
  final bool hasItems;
  final Function saveShoppingList;

  _SetListNameAndDescriptionActionButton({
    this.next,
    this.canMoveToSetItem,
    this.hasItems,
    this.saveShoppingList,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: (hasItems) ? ButtonType.secondary : ButtonType.primary,
            text: "Done",
            contentPosition: Position.center,
            disabled: (!canMoveToSetItem ||
                (context.watch<ShoppingListViewModel>().state ==
                    ViewState.busy)),
            onPressed: () => saveShoppingList(context: context),
            loading:
                context.watch<ShoppingListViewModel>().state == ViewState.busy,
          ),
        ),
        if (hasItems) Separator(dimension: Dimension.width),
        if (hasItems)
          ExpandedView(
            child: ActionButton(
              buttonType:
                  (canMoveToSetItem) ? ButtonType.primary : ButtonType.disable,
              text: "Add Items",
              icon: Icons.keyboard_arrow_right,
              iconPosition: Position.right,
              contentPosition: Position.center,
              onPressed: next,
              disabled: context.watch<ShoppingListViewModel>().state ==
                  ViewState.busy,
            ),
          ),
      ],
    );
  }
}
