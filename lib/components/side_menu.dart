import 'package:flutter/material.dart';
import 'package:nlu/components/side_menu_tile.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../constant/routes.dart';
import '../domain/user.dart';
import '../models/rive_asset.dart';
import '../provider/change_widget_notifier.dart';
import '../utils/rive_utils.dart';
import 'info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    required this.user,
    required this.onMenuChanged,
    required this.selectedMenu,
  }) : super(key: key);

  final User user;
  final Function onMenuChanged;
  final RiveAsset selectedMenu;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late ChangeWidgetNotifier changeWidgetNotifier;

  @override
  void didChangeDependencies() {
    changeWidgetNotifier = Provider.of<ChangeWidgetNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: widget.user.ten_day_du.toUpperCase(),
                id: widget.user.ma_sv,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    widget.onMenuChanged(menu);
                    changeWidgetNotifier.changeActiveWidget(routes[menu.route]!);
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                  },
                  isActive: widget.selectedMenu == menu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Settings".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenu2.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    widget.onMenuChanged(menu);
                    changeWidgetNotifier.changeActiveWidget(routes[menu.route]!);
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                  },
                  isActive: widget.selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
