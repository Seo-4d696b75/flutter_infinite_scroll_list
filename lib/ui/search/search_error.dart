import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchErrorNotifierProvider = ChangeNotifierProvider(
  (_) => SearchErrorNotifier(),
);

enum SearchErrorType {
  first,
  loadMore,
  refresh,
}

class SearchErrorNotifier extends ChangeNotifier {
  late SearchErrorType _type;

  SearchErrorType get type => _type;

  void onError(SearchErrorType type) {
    _type = type;
    notifyListeners();
  }
}
