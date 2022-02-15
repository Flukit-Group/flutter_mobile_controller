# mobile_controller

A new Flutter project for PC to control mobiles by adb tool.
> Develop in progress, not release yet...

## Features
- Provide computer control mobile phone shortcut keys
- Mobile device and application information extraction display
- Support for custom commands
- Provide a script to automate the control of Tiktok or any other apps
- Multi-platform supported (MacOs, Windows, Linux)

## Progress & Todo
- [x] Terminal Technology Research
- [x] UI framework construction on PC
- [ ] Display connected device list
- [ ] Query and display brief information about devices
- [ ] Automatically control device sliding, input text, etc.
- [ ] Construct steps of script by hand (set positions or input contents) without any code.
- [ ] User can collect and customize any other commands.
- [ ] Show script execution history records and quick run again.

## Technology Design
- Shield the input and output processing details of different commands through strategy mode
- Use the Chain of Responsibility pattern to assemble different steps to generate scripting concepts

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Thanks
- [flutter_mobile_command_tools](https://github.com/LuckyLi706/flutter_mobile_command_tools)
- [Using Flutter to build a native-looking desktop app for macOS and Windows](https://blog.whidev.com/native-looking-desktop-app-with-flutter/)