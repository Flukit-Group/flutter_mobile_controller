

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/config/constants.dart';
import 'package:mobile_controller/model/device_result.dart';
import 'package:mobile_controller/pages/recommend_scripts_page.dart';
import 'package:mobile_controller/pages/setting_page.dart';
import 'package:mobile_controller/style/theme.dart';
import 'package:mobile_controller/utils/log_helper.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:mobile_controller/command/command_controller.dart';

import 'mobile_connections_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;

  int index = 0;

  final settingsController = ScrollController();
  final flyoutController = FlyoutController();
  List<DeviceResult> _connectedDevList = [];

  @override
  void initState() {
    _refreshDevList();
    super.initState();
  }

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
  void dispose() {
    settingsController.dispose();
    flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    final noDeviceButton = Button(
        child: Text('无设备连接'),
        onPressed: () {
          _refreshDevList();
        }
    );
    final List<DropDownButtonItem> dropItems = List.generate(_connectedDevList.length, (index) => DropDownButtonItem(
      title: Text(_connectedDevList[index].devName!, softWrap: true,),
      leading: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: _connectedDevList[index].online ? Colors.green : Colors.red
        ),
      ),
      onTap: () {},
    ));
    return NavigationView(
      appBar: NavigationAppBar(
        height: 64,
        automaticallyImplyLeading: false,
        // height: !kIsWeb ? appWindow.titleBarHeight : 31.0,
        title: () {
          if (kIsWeb) return const Text(Constants.windowTitle);
          return Padding(
            padding: EdgeInsets.only(top: appWindow.titleBarHeight),
            child: MoveWindow(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28.0),
                    child: Text(Constants.windowTitle, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: 'Connected Devices',
                        child: dropItems.isEmpty ? noDeviceButton : DropDownButton(
                          controller: flyoutController,
                          contentWidth: 180,
                          leading: const Icon(FluentIcons.cell_phone),
                          title: Text(_connectedDevList.isEmpty ? '无设备连接' : _connectedDevList[0].devName!, style: FluentTheme.of(context).typography.body,),
                          items: dropItems,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0, left: 10),
                        child: Tooltip(
                          message: 'Refresh devices',
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(FluentIcons.refresh, size: 16),
                            style: ButtonStyle(
                              border: ButtonState.all(
                                BorderSide(
                                  color: FluentTheme.of(context).typography.title?.color?.withOpacity(0.2) ?? Colors.black.withOpacity(0.12),
                                  width: 0.6
                                )
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : MoveWindow(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [Spacer(), WindowButtons()],
          ),
        ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 180,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size: 100,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicatorBuilder: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return NavigationIndicator.end;
            case NavigationIndicators.sticky:
            default:
              return NavigationIndicator.sticky;
          }
        }(),
        items: [
          // It doesn't look good when resizing from compact to open
          // PaneItemHeader(header: Text('User Interaction')),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.connect_virtual_machine),
            title: const Text('Dashboard'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.mobile_angled),
            title: const Text('Mobile Control'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.network_tower),
            title: const Text('Wifi Connection'),
          ),
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.cost_control),
            title: const Text('Sample Scripts'),
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.bug),
            title: const Text('Report a Bug'),
            link: 'https://github.com/Moosphan/flutter_mobile_controller/issues/new'
          ),
          PaneItem(
            icon: Icon(
              appTheme.displayMode == PaneDisplayMode.top
                  ? FluentIcons.more
                  : FluentIcons.more_vertical,
            ),
            title: const Text('Others'),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
        ],
        // autoSuggestBox: AutoSuggestBox(
        //   controller: TextEditingController(),
        //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        // ),
        // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
          ),
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.alert_solid),
            title: const Text('Source code'),
            link: 'https://github.com/Moosphan/flutter_mobile_controller',
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        const MobileConnectionPage(),
        const Placeholder(),
        const Placeholder(),
        const RecommendScriptsPage(),
        const Placeholder(),
        const Placeholder(),
        const SettingsPage(),
      ]),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    assert(debugCheckHasFluentLocalizations(context));
    final ThemeData theme = FluentTheme.of(context);
    final buttonColors = WindowButtonColors(
      iconNormal: theme.inactiveColor,
      iconMouseDown: theme.inactiveColor,
      iconMouseOver: theme.inactiveColor,
      mouseOver: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.hovering}),
      mouseDown: ButtonThemeData.buttonColor(
          theme.brightness, {ButtonStates.pressing}),
    );
    final closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red,
      mouseDown: Colors.red.dark,
      iconNormal: theme.inactiveColor,
      iconMouseOver: Colors.red.basedOnLuminance(),
      iconMouseDown: Colors.red.dark.basedOnLuminance(),
    );
    return Row(children: [
      Tooltip(
        message: FluentLocalizations.of(context).minimizeWindowTooltip,
        child: MinimizeWindowButton(colors: buttonColors),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).restoreWindowTooltip,
        child: WindowButton(
          colors: buttonColors,
          iconBuilder: (context) {
            if (appWindow.isMaximized) {
              return RestoreIcon(color: context.iconColor);
            }
            return MaximizeIcon(color: context.iconColor);
          },
          onPressed: () {
            logI('max or min window');
            appWindow.maximizeOrRestore;
          },
        ),
      ),
      Tooltip(
        message: FluentLocalizations.of(context).closeWindowTooltip,
        child: CloseWindowButton(colors: closeButtonColors),
      ),
    ]);
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
    icon: icon,
    title: title,
    infoBadge: infoBadge,
    focusNode: focusNode,
    autofocus: autofocus,
  );

  final String link;

  @override
  Widget build(
      BuildContext context,
      bool selected,
      VoidCallback? onPressed, {
        PaneDisplayMode? displayMode,
        bool showTextOnTop = true,
        bool? autofocus,
      }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}