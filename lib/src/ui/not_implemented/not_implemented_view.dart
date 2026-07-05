import 'package:flutter/material.dart';

class NotImplementedView extends StatelessWidget {
  const NotImplementedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text("This page isn't built yet"),
          ],
        ),
      ),
    );
  }
}
