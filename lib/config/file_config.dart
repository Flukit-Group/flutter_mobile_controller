
import 'dart:io';

/// File configs of this application.
/// @author dorck
/// @date 2022/02/07
class FileConfig {
  FileConfig._();

  // Generated files configs (e.g., adb, apktool, app configs).
  static const String appDirName = 'MobileControlHelper';
  static const String toolsDirName = 'tools';
  static const String configDirName = 'config';
  static const String apktoolDirName = 'apktool';
  static const String uiToolDirName = 'uiautomatorviewer';

  // Abd Actually used.
  static String adbPath = '';
  static String javaPath = '';
  // Inner adb default path.
  static String internalAdbPath = '';
  // User customized adb.
  static String customizedAdbPath = '';
  // The cur user dir path.
  static String userPath = '';
  static String desktopPath = '';
  // libimobiledevice dir (A cross-platform software library
  // that talks the protocols to interact with iOS devices. )
  static String libDevicePath = '';
  // Path of apksigner.jar tool.
  static String apkSignerJarPath = '';
  // Path for json file of signer config.
  static String signerJsonPath = '';
  // Path of jks file.
  static String jksPath = '';
}