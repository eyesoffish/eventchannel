import 'package:flutter_test/flutter_test.dart';
import 'package:testplugin/testplugin.dart';
import 'package:testplugin/testplugin_platform_interface.dart';
import 'package:testplugin/testplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestpluginPlatform with MockPlatformInterfaceMixin implements TestpluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<EventChannelResult> getEventChannel(int index) {
    // TODO: implement getEventChannel
    throw UnimplementedError();
  }
}

void main() {
  final TestpluginPlatform initialPlatform = TestpluginPlatform.instance;

  test('$MethodChannelTestplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestplugin>());
  });

  test('getPlatformVersion', () async {
    Testplugin testpluginPlugin = Testplugin();
    MockTestpluginPlatform fakePlatform = MockTestpluginPlatform();
    TestpluginPlatform.instance = fakePlatform;

    expect(await testpluginPlugin.getPlatformVersion(), '42');
  });
}
