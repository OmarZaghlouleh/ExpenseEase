import 'package:flutter/material.dart';

class IntroProvider extends ChangeNotifier {
  int _currentPage = 0;
  int _lastPage = 0;
  bool _isAppbarTitleVisible = false;

  void setAppbarTitleVisiblity(bool value) {
    _isAppbarTitleVisible = value;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    if (_currentPage > _lastPage) _lastPage = _currentPage;
    notifyListeners();
  }

  void reset() {
    _currentPage = 0;
    _isAppbarTitleVisible = false;
  }

  int get getCurrentPage => _currentPage;
  int get getLastPage => _lastPage;

  bool get getAppbarTitleVisibilty => _isAppbarTitleVisible;
}
