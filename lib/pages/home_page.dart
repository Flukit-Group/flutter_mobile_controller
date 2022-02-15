
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';
import 'package:mobile_controller/config/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../command/command_controller.dart';
import '../config/command_config.dart';
import '../model/device_result.dart';
import '../utils/log_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.themeNotifier}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _currentIndex = 0;

  late ScrollController listController;
  late ScrollController settingsController;
  late FlapController _flapController;
  List<DeviceResult> _connectedDevList = [];

  _refreshDevList() {
    CommandController.executeAdbCommand(AdbCommand.deviceList).then((value) {
      logV('execute cmd result: adb devices >> $value');
      if (value.succeed) {
        setState(() {
          _connectedDevList = value.result;
        });
      }
    }).catchError((e) {
      logE('catch error: ' + e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshDevList();
    listController = ScrollController();
    settingsController = ScrollController();
    _flapController = FlapController();

    _flapController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    listController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final developers = {
      'Prateek Sunal': 'prateekmedia',
      'Malcolm Mielle': 'MalcolmMielle',
      'sim': 'simrat39',
      'Jesús Rodríguez': 'jesusrp98',
      'Polo': 'pablojimpas',
    };

    final noDeviceButton = AdwButton.flat(
        child: Text('无设备连接'),
        onPressed: () {
          _refreshDevList();
        }
    );

    final List<DropdownMenuItem> dropItems = List.generate(_connectedDevList.length, (index) => DropdownMenuItem<String>(
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _connectedDevList[index].online ? Colors.green : Colors.red
            ),
          ),
          Text(_connectedDevList[index].devName!, softWrap: true,),
        ],
      ),
      onTap: () {},
    ));

    return AdwScaffold(
      flapController: _flapController,
      headerbar: (_) => AdwHeaderBar.bitsdojo(
        appWindow: appWindow,
        start: [
          AdwHeaderButton(
            icon: const Icon(Icons.view_sidebar_outlined, size: 19),
            isActive: _flapController.isOpen,
            onPressed: () => _flapController.toggle(),
          ),
          AdwHeaderButton(
            icon: const Icon(Icons.nightlight_round, size: 15),
            onPressed: changeTheme,
          ),
        ],
        title: const Text(Constants.windowTitle),
        end: [
          Row(
            children: [
              Tooltip(
                message: 'Connected Devices',
                child: dropItems.isEmpty ? noDeviceButton : AdwComboButton(
                  choices: _connectedDevList.isEmpty ? ['无设备连接'] : _connectedDevList.map((dev) => dev.devName!).toList(),
                  selectedIndex: 0,
                  onSelected: (index) {

                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10),
                  child: Tooltip(
                    message: 'Refresh devices',
                    child: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(Icons.refresh_rounded, size: 22),
                    ),
                  )
              ),
            ],
          ),
          AdwPopupMenu(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AdwButton.flat(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: AdwButton.defaultButtonPadding.copyWith(
                    top: 10,
                    bottom: 10,
                  ),
                  child: const Text(
                    'Reset Counter',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const Divider(),
                AdwButton.flat(
                  padding: AdwButton.defaultButtonPadding.copyWith(
                    top: 10,
                    bottom: 10,
                  ),
                  child: const Text(
                    'Preferences',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                AdwButton.flat(
                  padding: AdwButton.defaultButtonPadding.copyWith(
                    top: 10,
                    bottom: 10,
                  ),
                  onPressed: () => showDialog<Widget>(
                    context: context,
                    builder: (ctx) => AdwAboutWindow(
                      issueTrackerLink:
                      'https://github.com/gtk-flutter/libadwaita/issues',
                      appIcon: Image.asset('assets/logo.png'),
                      credits: [
                        AdwPreferencesGroup.credits(
                          title: 'Developers',
                          children: developers.entries
                              .map(
                                (e) => AdwActionRow(
                              title: e.key,
                              onActivated: () =>
                                  launch('https://github.com/${e.value}'),
                            ),
                          )
                              .toList(),
                        ),
                      ],
                      copyright: 'Copyright 2021-2022 Gtk-Flutter Developers',
                      license: const Text(
                        'GNU LGPL-3.0, This program comes with no warranty.',
                      ),
                    ),
                  ),
                  child: const Text(
                    'About this Demo',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      flap: (isDrawer) => AdwSidebar(
        currentIndex: _currentIndex,
        isDrawer: isDrawer,
        children: const [
          AdwSidebarItem(
            label: 'Welcome',
          ),
          AdwSidebarItem(
            label: 'Counter',
          ),
          AdwSidebarItem(
            label: 'Lists',
          ),
          AdwSidebarItem(
            label: 'Avatar',
          ),
          AdwSidebarItem(
            label: 'Flap',
          ),
          AdwSidebarItem(
            label: 'View Switcher',
          ),
          AdwSidebarItem(
            label: 'Settings',
          ),
          AdwSidebarItem(
            label: 'Style Classes',
          )
        ],
        onSelected: (index) => setState(() => _currentIndex = index),
      ),
      body: AdwViewStack(
        animationDuration: const Duration(milliseconds: 100),
        index: _currentIndex,
        children: const [
          Placeholder(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
        ],
      ),
    );
  }
}