import 'package:flutter/material.dart';
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
  bool isClickLogout = false;

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
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isClickLogout = false;
                        });
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
                                    setState(() {
                                      isClickLogout = false;
                                    });
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
                      onTapDown: (details) {
                        setState(() {
                          isClickLogout = true;
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
                          color: isClickLogout ? primaryColor.withOpacity(0.5) : Colors.white,
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
                              "Đăng xuất",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                              size: getProportionateScreenWidth(20),
                            ),
                          ],
                        ),
                      ),
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
