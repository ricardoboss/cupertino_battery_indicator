![GitHub License](https://img.shields.io/github/license/ricardoboss/cupertino_battery_indicator)
[![Pub Version](https://img.shields.io/pub/v/cupertino_battery_indicator)](https://pub.dev/packages/cupertino_battery_indicator)
[![Pub Points](https://img.shields.io/pub/points/cupertino_battery_indicator)](https://pub.dev/packages/cupertino_battery_indicator)
[![Pub Likes](https://img.shields.io/pub/likes/cupertino_battery_indicator)](https://pub.dev/packages/cupertino_battery_indicator)
[![Pub Monthly Downloads](https://img.shields.io/pub/dm/cupertino_battery_indicator)](https://pub.dev/packages/cupertino_battery_indicator)
[![Pipeline](https://github.com/ricardoboss/cupertino_battery_indicator/actions/workflows/dart.yml/badge.svg)](https://github.com/ricardoboss/cupertino_battery_indicator/actions/workflows/dart.yml)

This package provides a single widget: `BatteryIndicator`.
It resembles the battery icon used in the macOS menu bar, but is very customizable.
You can provide any value it should display.

![A gif showing the indicator and a slider being moved between 0% and 100%](https://raw.githubusercontent.com/ricardoboss/cupertino_battery_indicator/main/doc/example-slider.gif)

## Features

* Looks like a stylized battery laying on its side
* Shows any percentage given to it
* Customizable colors and sizes

## Getting started

Just include the `BatteryIndicator` library:

```dart
import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart';
```

## Usage

```dart
Widget buildIndicator(value) =>
  Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: BatteryIndicator(value: value),
      ),
      Text('${(value * 100).ceil()}%'),
    ],
  );
```

## Additional information

Feel free to open issues with suggestions or feature requests.

PRs are welcome!

## License

Licensed under the MIT license. Read more [here](./LICENSE).
