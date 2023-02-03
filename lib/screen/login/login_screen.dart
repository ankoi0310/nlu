import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nlu/components/custom_positioned.dart';
import 'package:nlu/config/size_config.dart';
import 'package:nlu/entry_point.dart';
import 'package:nlu/utils/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  bool isShowLoading = false, isShowConfetti = false;
  late DKMHProvider dkmhProvider;
  late ChangeWidgetNotifier changeWidgetNotifier;
  late SMITrigger check, error, reset, confetti;
  final List<String> errors = [];
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
        String username = _usernameController.text;
        String password = _passwordController.text;
        dkmhProvider.checkLogin(username, password).then((success) async {
          if (success) {
            check.fire();
            await saveBoolToPrefs("remember", remember);
            if (remember) {
              await saveStringToPrefs("username", username);
              await saveStringToPrefs("password", password);
            } else {
              await removeFromPrefs("username");
              await removeFromPrefs("password");
            }
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const EntryPoint()),
                  (Route<dynamic> route) => false,
                );
              });
            });
          } else {
            error.fire();
            Future.delayed(const Duration(seconds: 2), () {
              addError(error: kInvalidLogin);
              setState(() {
                isShowLoading = false;
              });
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
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBoolFromPrefs("remember"),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            remember = snapshot.data as bool;

            getStringFromPrefs("username").then((value) {
              if (_usernameController.text.isEmpty) {
                _usernameController.text = value ?? "";
              }
            });

            getStringFromPrefs("password").then((value) {
              if (_passwordController.text.isEmpty) {
                _passwordController.text = value ?? "";
              }
            });
          }

          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
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
                          FormError(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(10)),
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
                                  saveBoolToPrefs("remember", value!).then(
                                    (_) => setState(() {
                                      remember = value;
                                    }),
                                  );
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
                            ],
                          ),
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
        });
  }

  Padding buildUsernameFormField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: TextFormField(
        controller: _usernameController,
        onFieldSubmitted: (value) {
          _passwordFocusNode.requestFocus();
        },
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
        controller: _passwordController,
        focusNode: _passwordFocusNode,
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
