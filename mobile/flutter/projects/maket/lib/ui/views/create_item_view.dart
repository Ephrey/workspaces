import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/ui/views/base/expanded_view.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/views/base/stacked_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/in_stack_alert.dart';
import 'package:maket/ui/widgets/main_title.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/set_timeout.dart';
import 'package:provider/provider.dart';

class CreateItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelContainer(
      content: ScrollableView(
        child: ChangeNotifierProvider(
          create: (context) => locator<ItemViewModel>(),
          child: _CreateItemForm(),
        ),
      ),
    );
  }
}

class _CreateItemForm extends StatefulWidget {
  @override
  _CreateItemFormState createState() => _CreateItemFormState();
}

class _CreateItemFormState extends State<_CreateItemForm> {
  GlobalKey<FormState> _createItemFormKey = GlobalKey<FormState>();

  bool _canSubmitForm = false;
  bool _isItemCreate = false;
  bool _showAlert = false;
  String _alertMessage;

  TextEditingController _nameController;
  String _categoryValue = '';

  Status _nameState;
  Status _categoryState;

  List<String> _itemCategories = [];

  dynamic _handleNameFieldChange(String name) {
    final int nameLength = name.length;

    final bool _isValidName = (nameLength >= Forms.itemNameMinLength &&
        nameLength <= Forms.itemNameMaxLength);

    if (_isValidName && (_nameState == Status.success)) return false;

    setState(() {
      _nameState = (_isValidName) ? Status.success : Status.error;
    });
    _checkIfCanSubmitForm();
  }

  dynamic _handleCategoryChange(dynamic selectedCategory) {
    final bool _isValid = (selectedCategory != null);
    if (_isValid) _categoryValue = selectedCategory;
    if (_categoryState != Status.success) {
      setState(() => _categoryState = _getFieldState(_isValid));
    }
    _checkIfCanSubmitForm();
  }

  Status _getFieldState(bool state) => (state) ? Status.success : Status.error;

  void _checkIfCanSubmitForm() {
    setState(() {
      _canSubmitForm =
          (_nameState == Status.success && _categoryState == Status.success);
    });
  }

  Future<void> _handleCreateItem() async {
    setState(() => _canSubmitForm = false);

    final HttpResponse _response = await context.read<ItemViewModel>().create(
          item: ItemModel(
            name: _nameController.text,
            category: _categoryValue,
          ),
        );

    setState(() {
      _isItemCreate = _response.status;
      _alertMessage = _response.message;
    });

    if (_response.status) _resetForm();
    if (!_response.status) _checkIfCanSubmitForm();

    _showAlert = true;

    setTimeOut(
      callback: () => setState(() => _showAlert = false),
      seconds: Numbers.three,
    );
  }

  InStackAlert _getAlertMessage() {
    Status _messageType = _isItemCreate ? Status.success : Status.error;
    return InStackAlert(
      message: _alertMessage,
      messageType: _messageType,
    );
  }

  void _resetForm() {
    setState(() {
      _createItemFormKey.currentState.reset();
      _nameController.clear();
      _canSubmitForm = false;
    });
  }

  void _setCategories() {
    if (_itemCategories.length == 0) {
      _itemCategories = ItemConstants.getCategories();
    }
  }

  @override
  void setState(callback) {
    if (mounted) super.setState(callback);
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _setCategories();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StackedView(
      children: [
        Form(
          key: _createItemFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainTitle(text: 'Create an Item'),
              Separator(),
              FormInput(
                label: 'Item Name',
                controller: _nameController,
                onChange: _handleNameFieldChange,
                state: _nameState,
                autoFocus: true,
              ),
              Separator(),
              FormInput(
                inputType: InputType.dropdown,
                items: _itemCategories,
                label: 'Item Category',
                hintText: 'Select a Category',
                onChange: _handleCategoryChange,
                selectedValue: _categoryValue,
              ),
              Separator(),
              _CreateItemFormActionButton(
                canSubmit: _canSubmitForm,
                onDonePress: _handleCreateItem,
              ),
              // Loading(),
            ],
          ),
        ),
        if (_showAlert) _getAlertMessage(),
      ],
    );
  }
}

class _CreateItemFormActionButton extends StatelessWidget {
  final bool canSubmit;
  final Function onDonePress;

  _CreateItemFormActionButton({this.canSubmit, this.onDonePress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedView(
          child: ActionButton(
            buttonType: ButtonType.secondary,
            text: 'Back',
            icon: Icons.keyboard_arrow_left,
            contentPosition: Position.center,
            onPressed: () => pop(context: context),
            disabled: (context.watch<ItemViewModel>().state == ViewState.busy),
          ),
        ),
        Separator(dimension: Dimension.width),
        ExpandedView(
          child: ActionButton(
            buttonType: (canSubmit) ? ButtonType.primary : ButtonType.disable,
            text: 'Done',
            contentPosition: Position.center,
            onPressed: onDonePress,
            loading: (context.watch<ItemViewModel>().state == ViewState.busy),
          ),
        ),
      ],
    );
  }
}
