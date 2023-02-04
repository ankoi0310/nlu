import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nlu/components/custom_child_app_bar.dart';
import 'package:nlu/components/setting_tile.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/constant/timeline.dart';
import 'package:nlu/screen/setting/notification_setting/timeline/timeline_screen.dart';
import 'package:nlu/utils/app_utils.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIntFromPrefs("time_before"),
        builder: (context, snapshot) {
          final selectedTime = snapshot.hasData ? snapshot.data as int : 0;
          final selectedTimeLabel = timeBefore[selectedTime]!;

          return SafeArea(
            child: Scaffold(
              appBar: buildAppBar(
                context: context,
                title: "Thông báo học phần",
              ),
              body: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SettingTile(
                      enabled: true,
                      title: "Thời gian",
                      child: Text(
                        selectedTimeLabel,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimelineScreen(
                              selectedTime: selectedTime,
                            ),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    SettingTile(
                      enabled: true,
                      title: "Âm thanh",
                      child: const Text(
                        "Mặc định",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onPress: () {
                        Fluttertoast.showToast(
                          msg: "Chức năng đang được phát triển",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
