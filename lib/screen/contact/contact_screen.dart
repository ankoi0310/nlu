import 'package:flutter/material.dart';
import 'package:nlu/components/custom_app_bar.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/contact_info.dart';
import 'package:nlu/screen/contact/components/contact_info.dart';

class ContactScreen extends StatefulWidget {
  static String routeName = "/contact";
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: getProportionateScreenHeight(20),
              ),
              child: const CustomAppBar(
                title: "Liên hệ",
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Mọi thắc mắc, góp ý vui lòng liên hệ với mình qua các thông tin sau:",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: phone,
                      icon: Icons.phone,
                      isLink: false,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: email,
                      icon: Icons.email,
                      isLink: false,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: facebook,
                      icon: Icons.facebook,
                      isLink: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(50)),
                    Text(
                      "Nếu thấy hữu ích, bạn có thể ủng hộ mình qua các thông tin sau (nhấn vào để copy):",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: "VPBank - 42633102001 - HUYNH VAN HUU AN",
                      icon: Icons.credit_card,
                      isLink: false,
                      isCouldCopy: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: "BIDV - 31410003494070 - HUYNH VAN HUU AN",
                      icon: Icons.credit_card,
                      isLink: false,
                      isCouldCopy: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const ContactInfo(
                      content: "Momo - $phone",
                      icon: Icons.phone_android,
                      isLink: false,
                      isCouldCopy: true,
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    Text(
                      "Cảm ơn bạn đã ủng hộ!",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
