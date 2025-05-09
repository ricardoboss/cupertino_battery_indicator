import 'package:alchemist/alchemist.dart';
import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  GoldenTestGroup buildScenario(Brightness brightness) => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: '0%',
            child: _Wrapper(
              brightness: brightness,
              child: const BatteryIndicator(value: 0),
            ),
          ),
          GoldenTestScenario(
            name: '50%',
            child: _Wrapper(
              brightness: brightness,
              child: const BatteryIndicator(value: 0.5),
            ),
          ),
          GoldenTestScenario(
            name: '100%',
            child: _Wrapper(
              brightness: brightness,
              child: const BatteryIndicator(value: 1),
            ),
          ),
        ],
      );

  group('BatteryIndicator matches golden', () {
    goldenTest(
      'light',
      fileName: 'light',
      builder: () => buildScenario(Brightness.light),
    );

    goldenTest(
      'dark',
      fileName: 'dark',
      builder: () => buildScenario(Brightness.dark),
    );
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
