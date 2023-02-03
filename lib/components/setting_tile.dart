import 'package:flutter/material.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/constants.dart';

class SettingTile extends StatefulWidget {
  const SettingTile({
    super.key,
    required this.enabled,
    required this.title,
    required this.onPress,
    required this.child,
  });

  final bool enabled;
  final String title;
  final VoidCallback onPress;
  final Widget child;

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onPress : null,
        onTapCancel: () {
          setState(() {
            isClick = false;
          });
        },
        onTapDown: (details) {
          setState(() {
            isClick = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            isClick = false;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(15),
            horizontal: getProportionateScreenWidth(20),
          ),
          margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            color: isClick && widget.enabled ? primaryColor.withOpacity(0.5) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
