import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';

class ShoppingListViewModel extends BaseViewModel {
  final ShoppingListService _service = locator<ShoppingListService>();

  HttpResponse _response = Response.build();

  int _selectedListCounter = 0;

  HttpResponse get response => _response;

  int get getSelectedListCounter => _selectedListCounter;

  Future<HttpResponse> create({ShoppingListModel shoppingList}) async {
    busy;
    try {
      await _service.create(shoppingList: shoppingList.toJson());

      idle;
      return Response.build(message: 'List Successfully Created.');
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: 'Failed to create.');
    }
  }

  Future<void> getAllListBodies() async {
    busy;
    try {
      List<dynamic> _shoppingListBodiesJson = await _service.getAllListBodies();

      List<ShoppingListModel> _shoppingLists =
          ShoppingListModel.shoppingListBodiesFromJson(
        jsonShoppingListBodies: _shoppingListBodiesJson,
      );

      _response = Response.build(data: _shoppingLists);

      idle;
    } on ApiException catch (ex) {
      _response =
          Response.build(status: false, code: ex.code, message: ex.message);

      idle;
    } catch (ex) {
      _response =
          Response.build(status: false, message: 'Failed to get Lists.');

      idle;
    }
  }

  Future<void> selectShoppingList({ShoppingListModel list}) async {
    busy;
    List<ShoppingListModel> _lists = [];

    for (ShoppingListModel oldList in _response.data) {
      if (oldList.id == list.id) {
        oldList.selected = !list.selected;
        _lists.add(oldList);
      } else {
        _lists.add(oldList);
      }
    }
    _response.data = _lists;
    idle;
  }

  Future<void> unselectAllShoppingLists() async {
    busy;
    List<ShoppingListModel> _lists = [];

    for (ShoppingListModel list in _response.data) {
      list.selected = false;
      _lists.add(list);
    }

    _response.data = _lists;
    idle;
  }

  Future<void> selectAllShoppingLists({bool shouldSelect}) async {
    busy;
    List<ShoppingListModel> _lists = [];

    for (ShoppingListModel list in _response.data) {
      list.selected = shouldSelect;
      _lists.add(list);
    }

    _response.data = _lists;
    idle;
  }

  Future<void> deleteSelectedShoppingLists() async {
    busy;
    List<ShoppingListModel> _lists = [];

    for (ShoppingListModel list in _response.data) {
      if (!list.selected) _lists.add(list);
    }

    _response.data = _lists;
    idle;
  }

  Future<void> countSelectedList() async {
    busy;
    int _counter = 0;
    for (ShoppingListModel list in _response.data) {
      if (list.selected) _counter++;
    }
    _selectedListCounter = _counter;
    idle;
  }
}
