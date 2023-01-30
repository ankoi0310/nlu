import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../config/size_config.dart';
import '../../entry_point.dart';
import '../../utils/rive_utils.dart';
import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.isLoggedIn = false});

  final bool isLoggedIn;

  @override
  State<StatefulWidget> createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  late SMIBool isLoading;
  late SMINumber progress;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox.expand(
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
            Future.delayed(const Duration(seconds: 5), () {
              isLoading.change(false);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.isLoggedIn ? const EntryPoint() : const LoginScreen()));
            });
          });
        },
      ),
    );
  }
}
