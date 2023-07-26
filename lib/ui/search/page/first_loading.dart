import 'package:flutter/material.dart';

class FirstLoadingPage extends StatelessWidget {
  const FirstLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
