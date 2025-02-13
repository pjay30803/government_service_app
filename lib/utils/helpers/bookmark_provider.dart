import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  List<Map<String, dynamic>> _bookmarks = [];

  List<Map<String, dynamic>> get bookmarks => _bookmarks;

  void changeBookmark(Map<String, dynamic> service) {
    _bookmarks.contains(service)
        ? _bookmarks.remove(service)
        : _bookmarks.add(service);
    notifyListeners();
  }
}
