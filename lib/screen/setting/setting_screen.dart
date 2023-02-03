import 'package:flutter/material.dart';
import 'package:nlu/components/setting_tile.dart';
import 'package:nlu/screen/setting/components/setting_title.dart';
import 'package:nlu/screen/setting/notification_setting/notification_setting_screen.dart';
import 'package:provider/provider.dart';

import '../../components/custom_app_bar.dart';
import '../../config/size_config.dart';
import '../../constant/constants.dart';
import '../../provider/dkmh_provider.dart';
import '../login/login_screen.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/setting";
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late DKMHProvider provider;
  bool isDarkMode = false;

  @override
  void didChangeDependencies() {
    provider = Provider.of<DKMHProvider>(context, listen: false);
    super.didChangeDependencies();
  }

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
                title: "Cài đặt",
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingTitle(title: "Giao diện"),
                  SettingTile(
                    enabled: false,
                    title: "Chế độ ban đêm",
                    onPress: () {},
                    child: SizedBox(
                      height: getProportionateScreenHeight(20),
                      child: Switch(
                        value: isDarkMode,
                        mouseCursor: MouseCursor.defer,
                        activeColor: primaryColor,
                        activeTrackColor: primaryColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SettingTitle(title: "Hệ thống"),
                  SettingTile(
                    enabled: true,
                    title: "Thông báo học phần",
                    onPress: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const NotificationSettingScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1, 0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.access_time,
                      color: Colors.blueAccent,
                      size: getProportionateScreenWidth(20),
                    ),
                  ),
                  const SettingTitle(title: "Tài khoản"),
                  SettingTile(
                    enabled: true,
                    title: "Đăng xuất",
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Đăng xuất"),
                            content: const Text("Bạn có muốn đăng xuất không?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Hủy"),
                              ),
                              TextButton(
                                onPressed: () {
                                  provider.logout();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) => const LoginScreen(),
                                      transitionsBuilder: (context, animation1, animation2, child) => SlideTransition(
                                        position: Tween(
                                          // slide from left to right
                                          begin: const Offset(-1, 0),
                                          end: Offset.zero,
                                        ).animate(animation1),
                                        child: child,
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: const Text("Đăng xuất"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      color: Colors.redAccent,
                      size: getProportionateScreenWidth(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
