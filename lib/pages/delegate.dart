import 'package:flutter/material.dart';

class DelegatePage extends StatelessWidget {
  const DelegatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delegate"),
      ),
      body: const Center(
        child: Text("Delegate Page"),
      ),
    );
  }
}
