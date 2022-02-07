import 'package:fluent_ui/fluent_ui.dart';

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  AccentColor _color = systemAccentColor;
  AccentColor get color => _color;
  set color(AccentColor color) {
    _color = color;
    notifyListeners();
  }

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    notifyListeners();
  }
}

AccentColor get systemAccentColor {
  return AccentColor('normal', {
    'darkest': Color(0xff01030D),
    'darker': Color(0xff04071B),
    'dark': Color(0xff040921),
    'normal': Color(0xff050A25),
    'light': Color(0xff2B2F46),
    'lighter': Color(0xff505466),
    'lightest': Color(0xff828592),
  });
}