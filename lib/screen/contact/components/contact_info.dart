import 'package:flutter/material.dart';
import 'package:nlu/config/size_config.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
    required this.content,
    required this.icon,
    required this.isLink,
  });

  final String content;
  final IconData icon;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: getProportionateScreenWidth(20),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        isLink
            ? GestureDetector(
                onTap: () {
                  launchUrlString(
                    content,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(16),
                    color: Colors.blueAccent,
                  ),
                ),
              )
            : Text(
                content,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                ),
              ),
      ],
    );
  }
}
