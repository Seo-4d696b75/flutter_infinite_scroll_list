import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_error.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showErrorShackBar({
  required BuildContext context,
  required WidgetRef ref,
  required SearchErrorType type,
}) {
  final manager = ScaffoldMessenger.of(context);
  final l = L10n.of(context);
  final snackBar = SnackBar(
    content: Text(l.searchErrorSnackBarMessage),
    behavior: SnackBarBehavior.floating,
    action: type == SearchErrorType.loadMore
        ? SnackBarAction(
            label: l.retrySearchButtonLabel,
            onPressed: ref.read(searchResultProvider.notifier).loadMore,
          )
        : null,
  );
  manager.showSnackBar(snackBar);
}
