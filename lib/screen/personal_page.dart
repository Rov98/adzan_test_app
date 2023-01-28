import 'package:adzan_test_app/widget/appbar_Default.dart';
import 'package:flutter/material.dart';

class Personal_Page extends StatelessWidget {
  const Personal_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_default(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: const Text('Personel Page'),
      ),
    );
  }
}
