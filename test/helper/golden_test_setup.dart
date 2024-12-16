import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> setupGoldenTests({
    Size screenSize = const Size(2400, 3200),
    double pixelRatio = 3,
  }) async {
    binding.window.physicalSizeTestValue = screenSize;
    binding.window.devicePixelRatioTestValue = pixelRatio;
  }
}
