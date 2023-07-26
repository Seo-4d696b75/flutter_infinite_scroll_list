import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          const Text('An Error happened'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO call reload operation
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}