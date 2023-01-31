import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:nlu/utils/notifications.dart';
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
                  const SettingTitle(
                    title: "Giao diện",
                  ),
                  SettingTile(
                    title: "Chế độ ban đêm",
                    onPress: () {},
                    child: SizedBox(
                      height: getProportionateScreenHeight(20),
                      child: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                        activeColor: primaryColor,
                        activeTrackColor: primaryColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SettingTitle(
                    title: "Hệ thống",
                  ),
                  SettingTile(
                    title: "Thông báo",
                    onPress: () {
                      createNotification(
                        title: "Công nghệ phần mềm",
                        body: "Còn 5 giây nữa học phần sẽ bắt đầu",
                        schedule: NotificationCalendar(
                          allowWhileIdle: true,
                          repeats: true,
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute,
                          second: DateTime.now().second + 5,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications,
                      color: Colors.blueAccent,
                      size: getProportionateScreenWidth(20),
                    ),
                  ),
                  SettingTile(
                    title: "Thời gian hiển thị thông báo",
                    onPress: () {
                      showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: 'Thời gian hiển thị thông báo',
                        context: context,
                        transitionDuration: const Duration(milliseconds: 400),
                        transitionBuilder: (_, animation, __, child) {
                          Tween<Offset> tween = Tween(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          );
                          return SlideTransition(
                            position: tween.animate(
                              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                            ),
                            child: child,
                          );
                        },
                        pageBuilder: (context, _, __) => Center(
                          child: Container(
                            height: 650,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.94),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              child: ListView(
                                children: [
                                  const Text(
                                    "10 giây",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "20 giây",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.access_time,
                      color: Colors.blueAccent,
                      size: getProportionateScreenWidth(20),
                    ),
                  ),
                  const SettingTitle(
                    title: "Tài khoản",
                  ),
                  SettingTile(
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
          color: Colors.black,
        ),
      ),
    );
  }
}

class SettingTile extends StatefulWidget {
  const SettingTile({
    super.key,
    required this.title,
    required this.onPress,
    required this.child,
  });

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
        onTap: widget.onPress,
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
            color: isClick ? primaryColor.withOpacity(0.5) : Colors.white,
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
