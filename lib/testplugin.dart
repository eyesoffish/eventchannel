import 'testplugin_platform_interface.dart';

class Testplugin {
  Future<String?> getPlatformVersion() {
    return TestpluginPlatform.instance.getPlatformVersion();
  }

  Future<EventChannelResult> getEventChannel(int index) {
    return TestpluginPlatform.instance.getEventChannel(index);
  }
}
