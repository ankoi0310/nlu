import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nlu/constant/constants.dart';
import 'package:nlu/constant/routes.dart';
import 'package:nlu/provider/change_widget_notifier.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/home/home_screen.dart';
import 'package:nlu/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../config/size_config.dart';
import '../../entry_point.dart';
import '../../utils/rive_utils.dart';
import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  late DKMHProvider dkmhProvider;
  late ChangeWidgetNotifier changeWidgetNotifier;
  late SMIBool isLoading;
  late SMINumber progress;
  bool isLogging = false;

  @override
  void initState() {
    super.initState();
    dkmhProvider = Provider.of<DKMHProvider>(context, listen: false);
    changeWidgetNotifier = Provider.of<ChangeWidgetNotifier>(context, listen: false);
  }

  void login(BuildContext context) async {
    setState(() {
      isLogging = true;
    });
    String username = await getStringFromPrefs("username") as String;
    String password = await getStringFromPrefs("password") as String;
    dkmhProvider.checkLogin(username, password).then((success) async {
      Future.delayed(const Duration(seconds: 2), () {
        changeWidgetNotifier.changeActiveWidget(routes[HomeScreen.routeName]!);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EntryPoint()));
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Stack(
        children: [
          SizedBox.expand(
            child: RiveAnimation.asset(
              'assets/rive/tree_loading_bar.riv',
              fit: BoxFit.cover,
              onInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: 'Loading');
                isLoading = controller.findSMI('Downloading') as SMIBool;
                progress = controller.findSMI('Progress') as SMINumber;

                isLoading.change(true);
                Future.doWhile(() async {
                  await Future.delayed(const Duration(milliseconds: 10));
                  progress.value += 1;
                  return progress.value <= 100;
                }).whenComplete(() {
                  Future.delayed(const Duration(seconds: 4), () {
                    getBoolFromPrefs("remember").then((value) {
                      if (value!) {
                        login(context);
                      } else {
                        isLoading.change(false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    });
                  });
                });
              },
            ),
          ),
          isLogging
              ? Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
