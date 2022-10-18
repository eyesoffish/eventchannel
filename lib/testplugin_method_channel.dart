import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'testplugin_platform_interface.dart';

/// An implementation of [TestpluginPlatform] that uses method channels.
class MethodChannelTestplugin extends TestpluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('testplugin');
  final testPluginEventChannel = const EventChannel('testPluginEventChannel');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<EventChannelResult> getEventChannel(int index) async {
    Completer<int> completer = Completer<int>();
    int temp = 0;
    StreamController<int> streamController = StreamController<int>();
    testPluginEventChannel.receiveBroadcastStream({"index": index}).listen((event) {
      if (event["index"] == 5) {
        temp = 5;
        streamController.addError(Exception("error 5"));
      } else {
        streamController.add(event["index"]);
      }
    }, onDone: () {
      if (temp == 5) {
        completer.completeError(Exception("error 5"));
      } else {
        completer.complete(1000);
      }
    }).onError((e) => print("error = "));
    return EventChannelResult(streamController.stream, completer.future);
  }
}
