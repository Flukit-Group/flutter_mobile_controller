import 'package:adwaita/adwaita.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:mobile_controller/config/common_config.dart';
import 'package:mobile_controller/config/constants.dart';
import 'package:mobile_controller/pages/home_page.dart';
import 'package:mobile_controller/pages/my_home_page.dart';
import 'package:mobile_controller/style/theme.dart';
import 'package:mobile_controller/utils/initializer_helper.dart';
import 'package:provider/provider.dart';

/// Launcher of application.
/// @author dorck
/// @date 2022/02/07
bool darkMode = false;
/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CommonConfig.initAppVersion();
  await InitializerHelper.init(CommonConfig.configs);
  Future.delayed(const Duration(milliseconds: 100), () {
    runApp(MyApp());
  });

  if (isDesktop) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(410, 540);
      win.size = const Size(755, 545);
      win.alignment = Alignment.center;
      win.title = Constants.windowTitle;
      win.show();
    });
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: Constants.windowTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {'/': (_) => const MyHomePage()},
          theme: ThemeData(
            accentColor: appTheme.color,
            brightness: appTheme.mode == ThemeMode.system
                ? darkMode
                ? Brightness.dark
                : Brightness.light
                : appTheme.mode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
        );
      },
    );
  }
}

class MyNewApp extends StatelessWidget {
  MyNewApp({Key? key}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return material.MaterialApp(
          theme: AdwaitaThemeData.light(),
          darkTheme: AdwaitaThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: HomePage(themeNotifier: themeNotifier),
          themeMode: currentMode,
        );
      },
    );
  }
}