import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:flutter_infinite_scroll_list/ui/search/page/empty_result_page.dart';
import 'package:flutter_infinite_scroll_list/ui/search/page/error_page.dart';
import 'package:flutter_infinite_scroll_list/ui/search/page/first_loading.dart';
import 'package:flutter_infinite_scroll_list/ui/search/page/search_result_page.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_result.dart';
import 'package:flutter_infinite_scroll_list/ui/search/section/search_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.searchAppBarTitle),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SearchTextField(),
            SizedBox(height: 20),
            Expanded(
              child: _SearchScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchScreenContent extends ConsumerWidget {
  const _SearchScreenContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchResultProvider);
    if (state.hasValue && state.requireValue.list.isNotEmpty) {
      return const SearchResultPage();
    } else if (state.isLoading) {
      return const FirstLoadingPage();
    } else if (state.hasError) {
      return const ErrorPage();
    } else {
      return const EmptyResultPage();
    }
  }
}
