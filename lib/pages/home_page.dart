
import 'package:flutter/material.dart';
import 'package:mobile_controller/config/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commands/command_controller.dart';
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

    final noDeviceButton = TextButton(
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

    return Scaffold(

    );
  }
}