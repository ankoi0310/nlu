import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlu/config/size_config.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
    required this.content,
    required this.icon,
    required this.isLink,
    this.isCouldCopy = false,
  });

  final String content;
  final IconData icon;
  final bool isLink;
  final bool isCouldCopy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: getProportionateScreenWidth(20),
        ),
        SizedBox(width: getProportionateScreenWidth(10)),
        SizedBox(
          width: SizeConfig.screenWidth * 0.8,
          child: isLink
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
              : isCouldCopy
                  ? GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: content),
                        );

                        List<String> infos = content.split(" - ");
                        for (String info in infos) {
                          await Clipboard.setData(
                            ClipboardData(text: info),
                          );
                        }

                        Fluttertoast.showToast(
                          msg: "Đã sao chép",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                        ),
                      ),
                    )
                  : Text(
                      content,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                      ),
                    ),
        ),
      ],
    );
  }
}
