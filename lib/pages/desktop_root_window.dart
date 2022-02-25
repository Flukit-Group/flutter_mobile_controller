import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_controller/commands/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/device_result.dart';
import 'package:mobile_controller/utils/log_helper.dart';

class DesktopRootWindow extends StatefulWidget {
  const DesktopRootWindow({Key? key}) : super(key: key);

  @override
  _DesktopRootWindowState createState() => _DesktopRootWindowState();
}

class _DesktopRootWindowState extends State<DesktopRootWindow> {
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
    _refreshDevList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // decoration: BoxDecoration(
        //   color: Colors.black.withOpacity(0.2),
        //   borderRadius: BorderRadius.circular(16)
        // ),
        color: Colors.black.withOpacity(0.1),
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDevList()),
                SizedBox(width: 20,),
                Expanded(child: _buildSettingPanel())
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDevList() {
    return Container(
      height: 200.0,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)
      ),
      child: _connectedDevList.isEmpty ? _buildEmptyView() : ListView.builder(
        itemBuilder: (context, index) {
          var item = _connectedDevList[index];
          return _renderDeviceItem(item);
        },
        itemCount: _connectedDevList.length,
      ),
    );
  }

  Widget _renderDeviceItem(DeviceResult result) => InkWell(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.blueAccent,
            ),
            child: Icon(
              result.connectType == ConnectType.wifi ? FluentIcons.wifi_1_20_regular : FluentIcons.usb_stick_20_regular,
              size: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result.devName ?? 'unknown', style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white
              ),),
              SizedBox(height: 8,),
              Text(result.modelType ?? 'unknown', style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.6)
              ),),
            ],
          )
        ],
      ),
    ),
  );

  Widget _buildSettingPanel() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white.withOpacity(0.2)
          ),
          child: Placeholder(),
        ),
        SizedBox(height: 10.0,),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white.withOpacity(0.2)
                ),
                child: Column(
                  children: [
                    Icon(FluentIcons.weather_sunny_16_regular, size: 24, color: Colors.white,),
                    SizedBox(height: 20,),
                    Text('Theme styles', style: TextStyle(
                        fontSize: 13,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white.withOpacity(0.2)
                ),
                child: Column(
                  children: [
                    Icon(FluentIcons.calendar_chat_20_regular, size: 24, color: Colors.white,),
                    SizedBox(height: 20,),
                    Text('Clear cache', style: TextStyle(
                        fontSize: 13,
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildEmptyView() => Center(
    child: Column(
      children: [
        Image.asset('assets/images/empty_dev_list.png',
          width: 96,
          height: 96,
        ),
        SizedBox(height: 20,),
        OutlinedButton(
          onPressed: () {
            _refreshDevList();
          },
          child: Text('重新载入'),
        ),
      ],
    ),
  );
}