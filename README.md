# Problem

cannot use ctrl+c / ctrl+v in native opened webview window. (note right click menu copy/paste does work)
seems to be related to PlatformMenuBar

## Steps to reproduce

Reproduces on: 
    Flutter master, 
    Flutter stable (3.7.0)

(note, you need to fully restart the app, hot reload/restart is not enough.)

(make sure `useMenuBar` is set to false)
Launch shortcut_problem with command `flutter run -d macos`, click button to open web view (and you should be able to copy paste text normally).

(make sure `useMenuBar` is set to true)
Launch shortcut_problem with command `flutter run -d macos`, click button to open web view, notice that you cannot use keyboard shortcuts, like copy paste.

## Notes

Menu items supplied are left blank, % adding items here does not prevent this issue.

Commenting out `channel.invokeMethod<void>(_kMenuSetMethod, windowMenu);` in `packages/flutter/lib/src/widgets/platform_menu_bar.dart` prevents the issue from appearing. of course also disabling menu bars.

This call appears to invoke a method in the flutter engine `flutter/engine`:`shell/platform/darwin/macos/framework/Source/FlutterMenuPlugin.mm:392`
