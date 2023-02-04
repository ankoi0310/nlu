import 'package:flutter/material.dart';
import 'package:nlu/components/custom_app_bar.dart';
import 'package:nlu/components/setting_tile.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/login/login_screen.dart';
import 'package:nlu/screen/setting/components/setting_title.dart';
import 'package:nlu/screen/setting/notification_setting/notification_setting_screen.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/setting";
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late DKMHProvider provider;
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
                  const SettingTitle(title: "Thông báo"),
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
