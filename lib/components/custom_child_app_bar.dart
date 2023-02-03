import 'package:flutter/material.dart';

AppBar buildAppBar({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
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
