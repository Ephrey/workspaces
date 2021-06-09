import 'package:flutter/material.dart';
import 'package:maket/constants/enums.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  /// [state] : get the current state that the view should have (loading or not)
  ViewState get state => _state;

  /// [idle] : set the current view to not busy (hide loading widget)
  void get idle => _setState(viewState: ViewState.idle);

  /// [busy] :  set the current view to busy (show loading widget)
  void get busy => _setState(viewState: ViewState.busy);

  void _setState({ViewState viewState}) {
    _state = viewState;
    print(viewState);
    notifyListeners();
  }
}
