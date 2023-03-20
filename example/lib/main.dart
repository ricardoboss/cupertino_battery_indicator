import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatefulWidget {
  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        home: CupertinoPageScaffold(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: BatteryIndicator(value: _value),
                ),
                Text('${(_value * 100).ceil()}%'),
                Slider(
                  value: _value,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (v) => setState(() => _value = v),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
