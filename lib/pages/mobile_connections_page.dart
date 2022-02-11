
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/repository/wx_auto_reply_repo.dart';
import 'package:mobile_controller/utils/log_helper.dart';

class MobileConnectionPage extends StatefulWidget {
  const MobileConnectionPage({Key? key}) : super(key: key);

  @override
  _MobileConnectionPageState createState() => _MobileConnectionPageState();
}

class _MobileConnectionPageState extends State<MobileConnectionPage> {

  String _executionResult = '';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      //header: const PageHeader(title: Text('Mobile Connections')),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      content: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey, width: 0.8)
                ),
                // TODO: Display connected devices list panel.
                child: material.SelectableText(_executionResult),
              ),

            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Button(
                      child: Text('刷新设备'),
                      onPressed: () {
                        CommandController.executeAdbCommand(AdbCommand.deviceList).then((value) {
                          logV('execute cmd result: adb devices >> $value');
                          if (value.succeed) {
                            var currentAllDevice = value.result;
                            logV("fetch device size: " + currentAllDevice.length.toString());
                            setState(() {
                              _executionResult = 'Result >> ' + value.result.toString();
                            });
                          } else {
                            logW('execute failed: $value');
                            setState(() {
                              _executionResult = 'Result >> ' + (value.result ?? value.toString());
                            });
                          }
                        }).catchError((e) {
                          setState(() {
                            _executionResult = e.toString();
                          });
                          logE('catch error: ' + e.toString());
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Button(
                      child: Text('微信自动回复脚本测试'),
                      onPressed: () {
                        WxAutoReplyRepository().openLiveEntrance().then((value) {
                          logV('execute script result: $value');
                          setState(() {
                            _executionResult = 'Result >> ' + value.toString();
                          });
                        });
                        //     .catchError((e) {
                        //   setState(() {
                        //     _executionResult = e.toString();
                        //   });
                        //   logE('catch error: ' + e.toString());
                        // });
                      },
                    ),
                    SizedBox(height: 20,),
                    Text('setting 3'),
                    SizedBox(height: 20,),
                    Text('setting 4'),
                    SizedBox(height: 20,),
                    Text('setting 5'),
                    SizedBox(height: 20,),
                    Text('setting 6'),
                    SizedBox(height: 20,),
                  ],
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
