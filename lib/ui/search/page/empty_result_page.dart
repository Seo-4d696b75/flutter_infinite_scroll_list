import 'package:flutter/material.dart';

class EmptyResultPage extends StatelessWidget {
  const EmptyResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(
            Icons.search_off_outlined,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text('No result found'),
        ],
      ),
    );
  }
}
