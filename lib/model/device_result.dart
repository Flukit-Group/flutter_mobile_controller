
import 'package:mobile_controller/utils/log_helper.dart';

/// Model of hardware device.
/// Todo: android sys version, battery, screen, ip or cpu info.
class DeviceResult {

  // Parse brief data from `adb devices -l`. e.g.:
  // `7e7910e7               device usb:336789504X product:OnePlus7T_CH model:HD1900 device:OnePlus7T transport_id:3`
  // 172.16.4.37:5555     device product:OnePlus7T_CH model:HD1900 device:OnePlus7T transport_id:3
  DeviceResult.from(String inputString) {
    var arguments = inputString.split(' ');
    logI('dev arguments: ' + arguments.toString(), tag: 'DeviceResult');
    serial = arguments[0];
    for (var element in arguments) {
      if (element.contains('usb:')) {
        usbPort = element.replaceFirst('usb:', '');
        connectType = ConnectType.usb;
      } else if (element.contains('device:')) {
        devName = element.replaceFirst('device:', '');
      } else if (element.contains('model:')) {
        modelType = element.replaceFirst('model:', '');
      } else if (element.contains('offline')) {
        online = false;
      } else if (element.contains(':5555')) {
        // Listening port of 5555 by default.
        connectType = ConnectType.wifi;
      }
    }
  }

  String? devName;
  String? modelType;
  String serial = '';
  String? usbPort;
  bool online = true;
  ConnectType? connectType;

  @override
  String toString() =>
      'Device{devName: $devName, model: $modelType, serial: $serial, online: $online, usbPort: $usbPort, connectType: $connectType}';
}

enum ConnectType {
  wifi,     // Old wifi connection way below 11.
  usb,
  wifi11,   // New wifi connection way on Android 11.
  usb_wifi  // Combined way support usb and wifi connections both.

}