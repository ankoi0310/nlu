import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nlu/provider/change_widget_notifier.dart';
import 'package:nlu/provider/dkmh_provider.dart';
import 'package:nlu/screen/home/home_screen.dart';
import 'package:nlu/utils/rive_utils.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'components/animated_bar.dart';
import 'components/side_menu.dart';
import 'constant/constants.dart';
import 'constant/routes.dart';
import 'models/menu_button.dart';
import 'models/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<StatefulWidget> createState() => _EntryPoint();
}

class _EntryPoint extends State<EntryPoint> with SingleTickerProviderStateMixin {
  late DKMHProvider dkmhProvider;
  late ChangeWidgetNotifier changeWidgetNotifier;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late SMIBool isSidebarClosed;
  RiveAsset selectedMenu = sideMenus.firstWhere((element) => element.route == HomeScreen.routeName);
  DateTime current = DateTime.now();
  RiveAsset selectedBottomNav = bottomNavs.firstWhere((element) => element.route == HomeScreen.routeName);
  bool isSideMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    dkmhProvider = Provider.of<DKMHProvider>(context, listen: false);
    changeWidgetNotifier = Provider.of<ChangeWidgetNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: backgroundColor2,
        body: Stack(
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(animation.value * 277, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Provider.of<ChangeWidgetNotifier>(context).activeWidget,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 300,
              left: isSideMenuClosed ? -300 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu(
                user: dkmhProvider.user!,
                onMenuChanged: (RiveAsset menu) {
                  isSidebarClosed.value = !isSidebarClosed.value;
                  if (isSideMenuClosed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = isSidebarClosed.value;
                    selectedMenu = menu;
                  });
                },
                selectedMenu: selectedMenu,
              ),
            ),
            MenuButton(
              riveOnInit: (artboard) {
                StateMachineController controller =
                    RiveUtils.getRiveController(artboard, stateMachineName: "State Machine");
                isSidebarClosed = controller.findSMI("isOpen") as SMIBool;
                isSidebarClosed.value = true;
              },
              press: () {
                isSidebarClosed.value = !isSidebarClosed.value;
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = isSidebarClosed.value;
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100 * animation.value),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: backgroundColor2.withOpacity(0.8),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    bottomNavs.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMenu = sideMenus.firstWhere(
                            (element) => element.route == bottomNavs[index].route,
                            orElse: () => sideMenu2.firstWhere(
                              (element) => element.route == bottomNavs[index].route,
                              orElse: () => sideMenus.firstWhere((element) => element.route == HomeScreen.routeName),
                            ),
                          );
                        });
                        changeWidgetNotifier.changeActiveWidget(routes[bottomNavs[index].route]!);
                        bottomNavs[index].input!.change(true);
                        if (selectedBottomNav != bottomNavs[index]) {
                          setState(() {
                            selectedBottomNav = bottomNavs[index];
                          });
                        }
                        Future.delayed(const Duration(seconds: 1), () {
                          bottomNavs[index].input!.change(false);
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBar(isActive: selectedBottomNav == bottomNavs[index]),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Opacity(
                              opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                              child: RiveAnimation.asset(
                                bottomNavs.first.src,
                                artboard: bottomNavs[index].artboard,
                                onInit: (artboard) {
                                  StateMachineController controller = RiveUtils.getRiveController(artboard,
                                      stateMachineName: bottomNavs[index].stateMachineName);
                                  bottomNavs[index].input = controller.findSMI('active') as SMIBool;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
