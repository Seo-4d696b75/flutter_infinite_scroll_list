import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showErrorShackBar({
  required BuildContext context,
  required WidgetRef ref,
  required SearchErrorType type,
}) {
  final manager = ScaffoldMessenger.of(context);
  final SnackBar snackBar;
  switch (type) {
    case SearchErrorType.first:
      snackBar = const SnackBar(
        content: Text('Search failed'),
        behavior: SnackBarBehavior.floating,
      );
      break;
    case SearchErrorType.loadMore:
      snackBar = SnackBar(
        content: const Text('Loading list failed'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () => ref.read(searchResultProvider.notifier).loadMore(),
        ),
      );
      break;
    case SearchErrorType.refresh:
      snackBar = const SnackBar(
        content: Text('Refresh failed'),
        behavior: SnackBarBehavior.floating,
      );
      break;
  }
  manager.showSnackBar(snackBar);
}
