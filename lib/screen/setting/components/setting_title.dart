import 'package:flutter/material.dart';
import 'package:nlu/config/size_config.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        top: getProportionateScreenHeight(20),
        bottom: getProportionateScreenHeight(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(18),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
