import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nlu/components/custom_positioned.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/entry_point.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/form_error.dart';
import '../../constant/constants.dart';
import '../../constant/routes.dart';
import '../../provider/change_widget_notifier.dart';
import '../../provider/dkmh_provider.dart';
import '../../utils/rive_utils.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode = FocusNode();
  bool isShowLoading = false, isShowConfetti = false;
  late DKMHProvider dkmhProvider;
  late ChangeWidgetNotifier changeWidgetNotifier;
  late SMITrigger check, error, reset, confetti;
  final List<String> errors = [];
  String username = '', password = '';
  bool remember = false;

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void login(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        dkmhProvider.checkLogin(username, password).then((success) {
          if (success) {
            check.fire();
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });

              confetti.fire();
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  isShowConfetti = false;
                });
                changeWidgetNotifier.changeActiveWidget(routes[HomeScreen.routeName]!);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EntryPoint()));
              });
            });
          } else {
            error.fire();
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });
              addError(error: kInvalidLogin);
            });
          }
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    dkmhProvider = Provider.of<DKMHProvider>(context, listen: false);
    changeWidgetNotifier = Provider.of<ChangeWidgetNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = SharedPreferences.getInstance();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: SizeConfig.screenWidth * 0.7,
                height: SizeConfig.screenWidth * 0.7,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: const SizedBox(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mã số sinh viên",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    buildUsernameFormField(),
                    const Text(
                      "Mật khẩu",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    buildPasswordFormField(),
                    Row(
                      children: [
                        Checkbox(
                          value: remember,
                          activeColor: primaryColor,
                          fillColor: MaterialStateProperty.resolveWith((states) => primaryColor.withOpacity(0.8)),
                          onChanged: (value) {
                            setState(() {
                              remember = value!;
                            });
                          },
                        ),
                        const Text(
                          "Ghi nhớ đăng nhập",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    FormError(errors: errors),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: ElevatedButton(
                        onPressed: () => login(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor.withOpacity(0.8),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                        ),
                        child: Text(
                          "Đăng nhập".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isShowLoading
                ? CustomPositioned(
                    child: RiveAnimation.asset(
                      "assets/rive/check.riv",
                      onInit: (artboard) {
                        StateMachineController controller = RiveUtils.getRiveController(artboard);
                        check = controller.findSMI('Check') as SMITrigger;
                        error = controller.findSMI('Error') as SMITrigger;
                        reset = controller.findSMI('Reset') as SMITrigger;
                      },
                    ),
                  )
                : const SizedBox(),
            isShowConfetti
                ? CustomPositioned(
                    child: Transform.scale(
                      scale: 7,
                      child: RiveAnimation.asset(
                        "assets/rive/confetti.riv",
                        onInit: (artboard) {
                          StateMachineController controller = RiveUtils.getRiveController(artboard);
                          confetti = controller.findSMI('Trigger explosion') as SMITrigger;
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Padding buildUsernameFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: TextFormField(
        onFieldSubmitted: (value) {
          _passwordFocusNode.requestFocus();
        },
        onSaved: (newValue) => username = newValue as String,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
            setState(() {
              errors.remove(kUsernameNullError);
            });
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kUsernameNullError)) {
            setState(() {
              errors.add(kUsernameNullError);
            });
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: "Nhập mã số sinh viên",
          hintStyle: TextStyle(color: Colors.black54),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding buildPasswordFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: TextFormField(
        focusNode: _passwordFocusNode,
        onSaved: (newValue) => password = newValue as String,
        onChanged: (value) {
          if (value.isNotEmpty && errors.contains(kPasswordNullError)) {
            setState(() {
              errors.remove(kPasswordNullError);
            });
          }
          return;
        },
        onFieldSubmitted: (value) => login(context),
        validator: (value) {
          if (value!.isEmpty && !errors.contains(kPasswordNullError)) {
            setState(() {
              errors.add(kPasswordNullError);
            });
            return "";
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Nhập mật khẩu",
          hintStyle: TextStyle(color: Colors.black54),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
