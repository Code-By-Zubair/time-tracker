import 'package:flutter/material.dart';

class BackLogTab extends StatefulWidget {
  const BackLogTab({super.key});

  @override
  State<BackLogTab> createState() => _BackLogTabState();
}

class _BackLogTabState extends State<BackLogTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This screen is not in figma'),
      ),
    );
  }
}
