
class Constants {
  Constants._();

  static const String windowTitle = 'Mobile Controller';

  // key-value storage keys.
  static const String innerAdbKey = "innerAdbPath"; //innerAdbPath对应的key
  static const String outerAdbKey = "outerAdbPath"; //outerAdbPath对应的key
  static const String javaKey = "javaPath";
  static const String libDeviceKey = "libDeviceKey";
  static const String isRootKey = "isRoot";
  static const String isInnerAdbKey = "isInnerAdb";

  // Command constants
  static const String ADB_COMMAND_DEVICES_LIST = 'devices';
  static const String ADB_COMMAND_WIRELESS_CONNECT = 'connect';
  static const String ADB_COMMAND_WIRELESS_DISCONNECT = 'disconnect';
  static const String ADB_COMMAND_VERSION = 'version';
}