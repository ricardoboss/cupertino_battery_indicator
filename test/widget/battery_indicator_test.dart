import 'dart:io';

import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> main() async {
  await loadAppFonts();

  final lightBuilder = GoldenBuilder.grid(
    columns: 1,
    widthToHeightRatio: 0.5,
    wrap: (child) => _Wrapper(
      brightness: Brightness.light,
      child: child,
    ),
  )
    ..addScenario(
      '0%',
      const BatteryIndicator(value: 0),
    )
    ..addScenario(
      '50%',
      const BatteryIndicator(value: 0.5),
    )
    ..addScenario(
      '100%',
      const BatteryIndicator(value: 1),
    );

  final darkBuilder = GoldenBuilder.grid(
    columns: 1,
    widthToHeightRatio: 0.5,
    wrap: (child) => _Wrapper(
      brightness: Brightness.dark,
      child: child,
    ),
  )
    ..addScenario(
      '0%',
      const BatteryIndicator(value: 0),
    )
    ..addScenario(
      '50%',
      const BatteryIndicator(value: 0.5),
    )
    ..addScenario(
      '100%',
      const BatteryIndicator(value: 1),
    );

  final osName = Platform.operatingSystem;

  testGoldens('BatteryIndicator matches golden ($osName)', (tester) async {
    await tester.pumpWidgetBuilder(
      lightBuilder.build(),
      surfaceSize: const Size(100, 304),
    );

    await screenMatchesGolden(tester, 'battery_indicator_${osName}_light');
  });

  testGoldens('BatteryIndicator matches golden ($osName, dark)', (tester) async {
    await tester.pumpWidgetBuilder(
      darkBuilder.build(),
      surfaceSize: const Size(100, 304),
    );

    await screenMatchesGolden(tester, 'battery_indicator_${osName}_dark');
  });
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child, required this.brightness});

  final Widget child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: brightness,
      ),
      child: Container(
        color: brightness == Brightness.light
            ? CupertinoColors.systemBackground.color
            : CupertinoColors.systemBackground.darkColor,
        width: 100,
        height: 50,
        child: Center(child: child),
      ),
    );
  }
}
