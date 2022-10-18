import Flutter
import UIKit

public class SwiftTestpluginPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "testplugin", binaryMessenger: registrar.messenger())
    let channel2 = FlutterEventChannel(name: "testPluginEventChannel", binaryMessenger: registrar.messenger())
    let instance = SwiftTestpluginPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    channel2.setStreamHandler(StreamChannelClass())
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
  
}

class StreamChannelClass: NSObject, FlutterStreamHandler {
  var eventSink: FlutterEventSink?
  var index = 0
  var _timer: Timer?
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events;
    guard let _index = (arguments as? Dictionary<String, Any>)?["index"] else {
      return FlutterError(code: "100", message: "error init", details: "error detail index = \(index)");
    }
    index = _index as! Int;
    if(index < 0) {
      return FlutterError(code: "200", message: "error init", details: "error detail index < 0, index = \(index)");
    }
    self._timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
      self.index += 1;
      self.eventSink?(["index":self.index])
      if(self.index == 20) {
        self._timer?.invalidate()
        self._timer = nil
        self.eventSink?(FlutterEndOfEventStream)
      }
    })
    return nil;
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil;
    return nil;
  }
}
