import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'testplugin_method_channel.dart';

abstract class TestpluginPlatform extends PlatformInterface {
  /// Constructs a TestpluginPlatform.
  TestpluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TestpluginPlatform _instance = MethodChannelTestplugin();

  /// The default instance of [TestpluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTestplugin].
  static TestpluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TestpluginPlatform] when
  /// they register themselves.
  static set instance(TestpluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<EventChannelResult> getEventChannel(int index) {
    throw UnimplementedError('getEventChannel() has not been implemented.');
  }
}

class EventChannelResult {
  final Stream<int> result;
  final Future<int> finish;

  EventChannelResult(this.result, this.finish);
}
