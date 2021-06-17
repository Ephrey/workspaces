import 'package:flutter/material.dart';
import 'package:maket/constants/colors.dart';
import 'package:maket/constants/enums.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/viewmodels/shopping_list_viewmodel.dart';
import 'package:maket/ui/widgets/buttons/action_button.dart';
import 'package:maket/ui/widgets/fields/form_field.dart';
import 'package:maket/ui/widgets/main_title.dart';
import 'package:maket/ui/widgets/model_container.dart';
import 'package:maket/ui/widgets/separator.dart';
import 'package:maket/utils/form.dart';
import 'package:maket/utils/gesture_handler.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/navigation/pop.dart';
import 'package:maket/utils/numbers.dart';
import 'package:maket/utils/screen_size.dart';

class SetItemPriceView extends StatefulWidget {
  final ItemModel item;

  SetItemPriceView({this.item});

  @override
  _SetItemPriceViewState createState() => _SetItemPriceViewState();
}

class _SetItemPriceViewState extends State<SetItemPriceView> {
  TextEditingController _controller;
  int _selectedQuantity;

  Status _priceState;

  bool _canSubmit = false;

  bool _isLoading = false;

  dynamic _handleItemPriceInput(String price) {
    double _price = Numbers.stringToDouble(price);

    if (_maxPriceExceeded(price: _price)) return false;

    if (_priceStateIsUnchanged(price: _price)) return false;

    if (_price >= Forms.minItemPrice) {
      _setState(() {
        _priceState = Status.success;
        _canSubmit = true;
      });
    } else {
      _setState(() {
        _priceState = Status.normal;
        _canSubmit = false;
      });
    }
  }

  bool _maxPriceExceeded({double price}) {
    bool _exceeded = price > Forms.maxItemPrice;

    if (_exceeded) {
      _setState(() {
        _canSubmit = false;
        _priceState = Status.error;
      });
    }
    return _exceeded;
  }

  bool _priceStateIsUnchanged({double price}) {
    return ((_priceState == Status.success) && (price >= Forms.minItemPrice));
  }

  void _onQuantityTap(int selectedQuantityId) {
    _setState(() => _selectedQuantity = selectedQuantityId);
    print(_selectedQuantity);
  }

  void _setItemPrice() async {
    _showLoader();

    ItemModel _item = widget.item;

    _item.price = Numbers.stringToDouble(_controller.text);
    _item.quantity = _selectedQuantity;
    _item.bought = !_item.bought;

    HttpResponse _res =
        await locator<ShoppingListViewModel>().setListItemPrice(item: _item);

    if (_res.status) pop(context: context);

    _hideLoader();
  }

  void _showLoader() => _setState(() => _isLoading = true);
  void _hideLoader() => _setState(() => _isLoading = false);

  void _setState(fn) {
    setState(fn);
    super.setState(fn);
  }

  @override
  void initState() {
    _controller = TextEditingController(text: widget.item.price.toString());
    _selectedQuantity = widget.item.quantity;
    if (widget.item.price > 0.0) {
      _setState(() {
        _priceState = Status.success;
        _canSubmit = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalContainer(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainTitle(text: 'Set "${widget.item.name}" Price'),
          Separator(distanceAsPercent: Numbers.three),
          FormInput(
            controller: _controller,
            keyBorderType: TextInputType.numberWithOptions(decimal: true),
            hintText: 'Type in the ${widget.item.name} price',
            textAlign: TextAlign.center,
            autoFocus: true,
            onChange: _handleItemPriceInput,
            state: _priceState,
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
