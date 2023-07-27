import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/data/repository/search_repository.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showDebugMenu(BuildContext context) {
  final l = L10n.of(context);
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(l.debugMenuTitle),
      content: const _DebugMenuContent(),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.debugMenuCloseCloseButtonLabel),
        ),
      ],
    ),
  );
}

class _DebugMenuContent extends ConsumerWidget {
  const _DebugMenuContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugDelay = ref.watch(debugSearchDelayMilliSecProvider);
    final debugError = ref.watch(debugSearchErrorFlagProvider);
    final l = L10n.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: Text(l.debugMenuDelayLabel),
          controlAffinity: ListTileControlAffinity.leading,
          value: debugDelay > 0,
          onChanged: (checked) {
            ref.read(debugSearchDelayMilliSecProvider.notifier).state =
                checked == true ? 1000 : 0;
          },
        ),
        CheckboxListTile(
          title: Text(l.debugMenuErrorLabel),
          controlAffinity: ListTileControlAffinity.leading,
          value: debugError,
          onChanged: (checked) {
            ref.read(debugSearchErrorFlagProvider.notifier).state =
                checked == true;
          },
        ),
      ],
    );
  }
}
