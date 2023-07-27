import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _fieldValidationProvider = StateProvider((_) => true);
final _fieldInvalidPattern = RegExp(r'^[\s ]+$');

class SearchTextField extends HookConsumerWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(
      text: ref.read(searchQueryProvider),
    );
    final validated = ref.watch(_fieldValidationProvider);

    void onChange(String value) {
      ref.read(_fieldValidationProvider.notifier).state =
          value.isNotEmpty && !_fieldInvalidPattern.hasMatch(value);
    }

    void onSubmit() {
      if (validated) {
        final query = controller.value.text;
        ref.read(searchQueryProvider.notifier).state = query;
      }
    }

    final l = L10n.of(context);

    return IntrinsicHeight(
      // TextFieldとButtonの高さ揃える
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            // Buttonの横幅確保して残りの幅いっぱいまで広げる
            child: TextField(
              controller: controller,
              onChanged: onChange,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: l.searchTextFieldLabel,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: validated ? onSubmit : null,
            child: Text(l.searchButtonLabel),
          ),
        ],
      ),
    );
  }
}
