import 'package:flutter/material.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        Navigator.pop(context, true);
      },
    ),
  );
}
