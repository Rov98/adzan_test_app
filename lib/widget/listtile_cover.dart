import 'package:flutter/material.dart';

class ListTile_Cover extends StatelessWidget {
  ListTile_Cover({super.key, required this.child});

  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Color(0xff0c82df), Color(0xff47a44b)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: child,
    );
  }
}
