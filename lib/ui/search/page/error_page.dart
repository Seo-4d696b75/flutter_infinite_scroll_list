import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 80,
        ),
        const SizedBox(height: 16),
        Text(l.searchErrorPageTitle),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.invalidate(searchResultProvider);
          },
          child: Text(l.retrySearchButtonLabel),
        ),
      ],
    );
  }
}
