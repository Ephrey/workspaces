import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/views/base/scrollable_view.dart';
import 'package:maket/ui/views/base/stacked_view.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/in_stack_alert.dart';
import 'package:maket/ui/widgets/main_title.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/ui/widgets/snackbar_alert.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';
import 'package:maket/utils/set_timeout.dart';
import 'package:maket/utils/snackbar/show_snackbar.dart';

class SetItemPriceView extends StatefulWidget {
  final ItemModel item;
  final String listId;

  SetItemPriceView({this.item, this.listId});

  @override
  _SetItemPriceViewState createState() => _SetItemPriceViewState();
}

class _SetItemPriceViewState extends State<SetItemPriceView> {
  TextEditingController _controller;
  int _selectedQuantity;

  Status _priceState;

  bool _canSubmit = false;

  bool _showAlert = false;
  String _alertMessage = '';

  bool _isLoading = false;

  dynamic _handleItemPriceInput(String price) {
    double _price = Numbers.stringToDouble(price);

    if (_maxPriceExceeded(price: _price)) return false;

    if (_priceStateIsUnchanged(price: _price)) return false;

    (_price >= Forms.minItemPrice) ? _setCanSubmit() : _setCannotSubmit();
  }

  bool _maxPriceExceeded({double price}) {
    bool _exceeded = price > Forms.maxItemPrice;
    if (_exceeded) _setCannotSubmit(status: Status.error);
    return _exceeded;
  }

  bool _priceStateIsUnchanged({double price}) {
    return ((_priceState == Status.success) && (price >= Forms.minItemPrice));
  }

  dynamic _onQuantityTap(int selectedQuantityId) {
    if (selectedQuantityId == _selectedQuantity) return false;
    _setState(() => _selectedQuantity = selectedQuantityId);
  }

  void _setItemPrice({Operations operation}) async {
    _showLoader();

    ItemModel _item = widget.item;

    if (operation == Operations.reset) {
      _item.price = Numbers.asDouble(Numbers.zero);
      _item.quantity = Numbers.one;
      _item.bought = false;
    } else {
      _item.price = Numbers.stringToDouble(_controller.text);
      _item.quantity = _selectedQuantity;
      _item.bought = true;
    }

    HttpResponse _res = await locator<ShoppingListViewModel>().setListItemPrice(
      item: _item,
      listId: widget.listId,
    );

    (_res.status) ? _onSetSuccess(res: _res) : _onSetFailed(res: _res);

    _hideLoader();
  }

  void _onSetSuccess({HttpResponse res}) {
    pop(context: context);
    showSnackBar(
      context: context,
      flavor: Status.success,
      content: SnackBarAlert(message: res.message),
    );
  }

  void _onSetFailed({HttpResponse res}) {
    _setState(() {
      _showAlert = true;
      _alertMessage = res.message;
    });

    setTimeOut(
      callback: () => setState(() => _showAlert = false),
      seconds: Numbers.three,
    );
  }

  void _showLoader() => _setState(() => _isLoading = true);
  void _hideLoader() => _setState(() => _isLoading = false);

  void _setCanSubmit() {
    _setState(() {
      _priceState = Status.success;
      _canSubmit = true;
    });
  }

  void _setCannotSubmit({Status status: Status.normal}) {
    _setState(() {
      _priceState = status;
      _canSubmit = false;
    });
  }

  InStackAlert _getAlertMessage() {
    return InStackAlert(
      message: _alertMessage,
      messageType: Status.error,
    );
  }

  GestureHandler _getSuffixIcon() {
    return (widget.item.bought)
        ? GestureHandler(
            child: Icon(FontAwesomeIcons.trashAlt, color: kErrorColor),
            onTap: () => _setItemPrice(operation: Operations.reset),
          )
        : null;
  }

  void _setState(fn) {
    setState(fn);
    super.setState(fn);
  }

  @override
  void initState() {
    ItemModel _item = widget.item;
    double _itemPrice = _item.price;

    bool _hasPrice = (_itemPrice >= Forms.minItemPrice);

    dynamic _defaultPrice = (_hasPrice) ? _itemPrice.toString() : null;

    _controller = TextEditingController(text: _defaultPrice);
    _selectedQuantity = _item.quantity;

    if (_hasPrice) _setCanSubmit();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      content: ScrollableView(
        child: StackedView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MainTitle(text: 'Set "${widget.item.name}" Price'),
                Separator(distanceAsPercent: Numbers.three),
                FormInput(
                  controller: _controller,
                  keyBorderType: TextInputType.numberWithOptions(decimal: true),
                  hintText: 'Type in "${widget.item.name}" price',
                  textAlign: TextAlign.center,
                  autoFocus: true,
                  onChange: _handleItemPriceInput,
                  state: _priceState,
                  suffixIcon: _getSuffixIcon(),
                ),
                Separator(),
                _QuantityButtons(
                  selectedQuantity: _selectedQuantity,
                  onQuantityTap: _onQuantityTap,
                ),
                Separator(distanceAsPercent: Numbers.four),
                ActionButton(
                  buttonType: (_canSubmit && !_isLoading)
                      ? ButtonType.primary
                      : ButtonType.disable,
                  text: 'Save',
                  contentPosition: Position.center,
                  onPressed: _setItemPrice,
                  loading: _isLoading,
                )
              ],
            ),
            if (_showAlert) _getAlertMessage(),
          ],
        ),
      ),
    );
  }
}

class _QuantityButtons extends StatelessWidget {
  final int selectedQuantity;
  final Function onQuantityTap;

  _QuantityButtons({this.selectedQuantity, this.onQuantityTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize(context: context).width,
      height:
          Numbers.size(context: context, percent: Numbers.five) + Numbers.four,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          return _QuantityButton(
            id: i + 1,
            selectedQuantity: selectedQuantity,
            onQuantityTap: onQuantityTap,
          );
        },
        separatorBuilder: (_, __) =>
            Separator(dimension: Dimension.width, thin: true),
        itemCount: Numbers.twentyFive,
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final int id;
  final int selectedQuantity;
  final Function onQuantityTap;

  _QuantityButton({this.id, this.selectedQuantity, this.onQuantityTap});

  @override
  Widget build(BuildContext context) {
    final bool _activeBtn = (id == selectedQuantity);

    final double _btnSize =
        (Numbers.size(context: context, percent: Numbers.five) + Numbers.four);

    final Color _btnBgColor = _activeBtn ? kPrimaryColor : kSecondaryColor;

    final TextStyle _textStyle = TextStyle(
      color: (_activeBtn) ? kTextPrimaryColor : kTextSecondaryColor,
      fontSize: 18.0,
    );

    return GestureHandler(
      child: Container(
        alignment: Alignment.center,
        width: _btnSize,
        color: _btnBgColor,
        child: Text('${id}x', style: _textStyle),
      ),
      onTap: () => onQuantityTap(id),
    );
  }
}
