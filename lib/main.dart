import 'package:flutter/material.dart';
import 'package:flutter_infinite_scroll_list/l10n/app_localizations.dart';
import 'package:flutter_infinite_scroll_list/ui/search/search_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchScreen(),
    );
  }
}
