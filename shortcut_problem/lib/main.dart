import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

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
          title: Text("Macos"),
        ),
        body: (false)
            ? MyContents()
            : PlatformMenuBar(
                menus: [],
                child: MyContents(),
              ),
      ),
    );
  }
}

class MyContents extends StatelessWidget {
  Future<void> doit() async {
    var offset = const Offset(0, 0);
    var windowSize = const Size(800, 600);
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
            'Open and see if you can copy paste:',
          ),
          TextButton(
              onPressed: () {
                doit();
              },
              child: Text('Open native view')),
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
