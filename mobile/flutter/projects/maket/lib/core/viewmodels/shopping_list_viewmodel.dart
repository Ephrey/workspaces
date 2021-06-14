import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';

class ShoppingListViewModel extends BaseViewModel {
  final ShoppingListService _service = locator<ShoppingListService>();

  HttpResponse _response = Response.build();

  int _selectedListCounter = Numbers.zero;

  HttpResponse get response => _response;

  int get getSelectedListCounter => _selectedListCounter;

  bool get hasLists => response.data.length > Numbers.zero;

  Future<HttpResponse> create({ShoppingListModel shoppingList}) async {
    busy;
    try {
      final Map<String, dynamic> _newlyCreatedList =
          await _service.create(shoppingList: shoppingList.toJson());

      await _addNewlyCreatedListToLocalLists(newList: _newlyCreatedList);

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
      if (!hasLists) {
        List<dynamic> _shoppingListJson = await _service.getAllListBodies();

        List<ShoppingListModel> _shoppingLists =
            ShoppingListModel.shoppingListBodiesFromJson(
                jsonShoppingListBodies: _shoppingListJson);

        _response = Response.build(data: _shoppingLists);
      }
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
    _response.data.forEach((ShoppingListModel currentList) {
      if (currentList.id == list.id) {
        currentList.selected = !list.selected;
      }
      return currentList;
    });
    idle;
  }

  Future<void> unselectAllShoppingLists() async {
    busy;
    _response.data.forEach((ShoppingListModel currentList) {
      currentList.selected = false;
      return currentList;
    });
    idle;
  }

  Future<void> selectAllShoppingLists({bool shouldSelect}) async {
    busy;
    _response.data.forEach((ShoppingListModel currentList) {
      currentList.selected = shouldSelect;
      return currentList;
    });
    idle;
  }

  Future<HttpResponse> deleteSelectedShoppingLists() async {
    busy;
    try {
      final List<String> _listIds = _getSelectedListsIds();

      final String _response = await _service.deleteMany(listIds: _listIds);

      await _removeSelectedListsFromCurrentLists(selectedListIds: _listIds);

      idle;
      return Response.build(message: _response);
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: 'Lists not deleted');
    }
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

  // Local Methods

  List<String> _getSelectedListsIds() {
    busy;
    List<String> _selectedListsIds = [];

    for (ShoppingListModel list in _response.data) {
      if (list.selected) _selectedListsIds.add(list.id);
    }

    idle;
    return _selectedListsIds;
  }

  Future<void> _removeSelectedListsFromCurrentLists({
    List<String> selectedListIds,
  }) async {
    _response.data.removeWhere((ShoppingListModel currentList) {
      return selectedListIds.contains(currentList.id);
    });
  }

  Future<void> _addNewlyCreatedListToLocalLists({
    Map<String, dynamic> newList,
  }) async {
    final ShoppingListModel _newListFromJson =
        ShoppingListModel.fromJson(json: newList);

    (hasLists)
        ? _response.data.insert(Numbers.zero, _newListFromJson)
        : response.data = [_newListFromJson];
  }
}
