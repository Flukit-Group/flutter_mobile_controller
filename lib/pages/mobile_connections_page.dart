
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:mobile_controller/command/android_command.dart';
import 'package:mobile_controller/config/constants.dart';
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.16),
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
                        var command = AndroidCommand();
                        command.execCommand([Constants.ADB_COMMAND_DEVICES_LIST]).then((value) {
                          logV('execute cmd result: adb devices >> ${value.stdout}');
                          var result = command.dealWithData(Constants.ADB_COMMAND_DEVICES_LIST, value);
                          if (result.error) {
                            logW('execute failed: $result');
                            setState(() {
                              _executionResult = 'Result >> ' + result.toString();
                            });
                          } else {
                            List<String> currentAllDevice = result.result;
                            logV("获取到的设备数量：" + currentAllDevice.length.toString());
                            currentAllDevice.forEach((element) {
                              if (element.contains("offline")) {
                                logI(element + ",当前设备不在线,移除列表");
                              } else {
                                logI(element);
                              }
                            });
                            currentAllDevice.removeWhere(
                                    (element) => element.contains("offline"));
                            setState(() {
                              _executionResult = 'Result >> ' + value.stdout.toString();
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
                    Text('setting 2'),
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
