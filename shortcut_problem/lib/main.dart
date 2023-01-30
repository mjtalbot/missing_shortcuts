import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

const useMenuBar = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Macos"),
        ),
        body: (useMenuBar)
            ? const PlatformMenuBar(
                menus: [],
                child: MyContents(),
              )
            : const MyContents(),
      ),
    );
  }
}

class MyContents extends StatelessWidget {
  const MyContents({super.key});

  Future<void> doit() async {
    await openWebView();
    await closeWebView();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Copy paste works inside the flutter app, but not the webview.',
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Copy paste works here...',
            ),
          ),
          TextButton(
              onPressed: () {
                doit();
              },
              child: const Text('Open webview')),
        ],
      ),
    );
  }
}

const MethodChannel _channel = MethodChannel('sample/window_util');
@override
Future<String?> openWebView() async {
  return _channel.invokeMethod<String>('openWebView', {});
}

@override
Future<bool?> closeWebView() {
  try {
    return _channel.invokeMethod<bool>('closeWebView', {});
  } on Exception catch (_) {
    return Future.value(false);
  }
}
