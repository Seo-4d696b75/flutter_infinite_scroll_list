import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';

class EmptyResultPage extends StatelessWidget {
  const EmptyResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.search_off_outlined,
          color: Colors.grey,
          size: 80,
        ),
        const SizedBox(height: 16),
        Text(l.searchEmptyPageTitle),
      ],
    );
  }
}
