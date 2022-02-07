
import 'package:package_info_plus/package_info_plus.dart';

/// Common configs of this application.
/// @author dorck
/// @date 2022/02/07
class CommonConfig {
  CommonConfig._();

  // We should initialize this `initAppVersion` at beginning of app launching.
  static String _appVers = '0.0';
  static get appVersion => _appVers;

  static initAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVers = packageInfo.version;
  }
}