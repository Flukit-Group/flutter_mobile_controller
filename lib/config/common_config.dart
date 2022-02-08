
import 'package:mobile_controller/utils/file_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Common configs of this application.
/// @author dorck
/// @date 2022/02/07
class CommonConfig {
  CommonConfig._();

  // We should initialize this `initAppVersion` at beginning of app launching.
  static String _appVers = '0.0';
  static get appVersion => _appVers;
  // TODO: delete!
  static String currentAndroidDevice = '';
  static bool isInnerAdb = false;

  static bool isRoot = false;

  // 全局参数配置
  static final Map<String, dynamic> _configs = {};
  static get configs => _configs;

  static initAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVers = packageInfo.version;
  }

  static updateConfigInfo(key, value) {
    _configs[key] = value;
    saveConfigInfo();
  }

  static saveConfigInfo() {
    FileUtils.writeSetting(_configs);
  }
}