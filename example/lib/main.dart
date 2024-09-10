import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  double _value = 0.5;
  bool _icon = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoApp(
        home: CupertinoPageScaffold(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: BatteryIndicator(
                    //trackHeight: 30.0,
                    value: _value,
                    icon: _icon
                        ? const Icon(CupertinoIcons.question,
                            color: Colors.black)
                        : null,
                    iconOutline: Colors.white,
                    iconOutlineBlur: 1.0,
                  ),
                ),
                Text('${(_value * 100).ceil()}%'),
                Slider(
                  value: _value,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (v) => setState(() => _value = v),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _icon,
                      onChanged: (v) => setState(() => _icon = v == true),
                    ),
                    const Text("Show Icon"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
