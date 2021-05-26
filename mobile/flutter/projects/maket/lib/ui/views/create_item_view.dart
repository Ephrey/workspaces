import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/constants/item_categories.dart';
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
  String _resultMessage;
  bool _showAlert = false;

  TextEditingController _nameController;
  String _categoryValue = '';

  Status _nameState;
  Status _categoryState;

  dynamic _handleNameFieldChange(String name) {
    final int nameLength = name.length;

    final bool _isValidName = (nameLength >= Forms.itemNameMinLength &&
        nameLength <= Forms.itemNameMaxLength);

    if (_isValidName && _nameState == Status.success) return false;

    _setState(() {
      _nameState = (_isValidName) ? Status.success : Status.error;
    });
    _checkCanSubmitForm();
  }

  dynamic _handleCategoryChange(dynamic selectedCategory) {
    final bool _isValid = (selectedCategory != null);

    if (_isValid != null) {
      _setState(() {
        _categoryValue = selectedCategory;
        if (!(_categoryState == Status.error)) _categoryState = Status.success;
      });
    } else {
      _setState(() => _categoryState = Status.error);
    }
    _checkCanSubmitForm();
  }

  void _checkCanSubmitForm() {
    _setState(() {
      _canSubmitForm =
          (_nameState == Status.success && _categoryState == Status.success);
    });
  }

  Future<void> _handleCreateItem() async {
    _setState(() => _canSubmitForm = false);

    final ItemModel _item = ItemModel(
      name: _nameController.text,
      category: _categoryValue,
    );

    final HttpResponse _response =
        await context.read<ItemViewModel>().create(item: _item);

    _setState(() {
      _isItemCreate = _response.status;
      _resultMessage = _response.message;
    });

    if (_response.status) _resetForm();
    if (!_response.status) _checkCanSubmitForm();

    _showAlert = true;

    setTimeOut(
      callback: () => _setState(() => _showAlert = false),
      waitingSecond: Numbers.three,
    );
  }

  InStackAlert _getAlertMessage() {
    Status _messageType = _isItemCreate ? Status.success : Status.error;
    return InStackAlert(
      message: _resultMessage,
      messageType: _messageType,
    );
  }

  void _resetForm() {
    _setState(() {
      _createItemFormKey.currentState.reset();
      _nameController.clear();
      _canSubmitForm = false;
    });
  }

  void _setState(callback) => setState(callback);

  @override
  void initState() {
    _nameController = TextEditingController();
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
                items: itemCategories,
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
