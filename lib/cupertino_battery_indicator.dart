import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A stylized battery indicator widget.
///
/// Example usage:
///
/// ```dart
///   Row(
///     children: const [
///       BatteryIndicator(value: 0.75),
///       SizedBox(width: 20),
///       Text('Battery: 75% left'),
///     ],
///   )
/// ```
class BatteryIndicator extends StatelessWidget {
  /// The default height of the battery indicator track. A bit smaller than the
  /// default body font size.
  static const defaultTrackHeight = 10.0;

  /// The default padding between the track and the indicator bar.
  static const defaultTrackPadding = 1.0;

  /// The default aspect ratio (width divided by height) of the indicator.
  static const defaultAspectRatio = 2.33;

  /// The value to show for this indicator. MUST be a value between 0 and 1
  /// (inclusive).
  final double value;

  /// The height of the track (i.e. container).
  final double trackHeight;

  /// The padding around the indicator bar. Must be 0 or greater.
  final double trackPadding;

  /// The background color for the indicator. Doesn't exceed the border.
  final Color? trackColor;

  /// The border color of the track. Also controls the color of the knob.
  final Color? trackBorderColor;

  /// The radius of the track border.
  final BorderRadiusGeometry? trackBorderRadius;

  /// The ratio between track width and height. Must be greater or equal to 1.
  /// If you want the indicator to be vertical, use a Transform.rotate widget:
  ///
  /// ```dart
  /// Transform.rotate(
  ///   angle: pi / 2, // 90°
  ///   child: BatteryIndicator(value: 0.1),
  /// ),
  /// ```
  final double trackAspectRatio;

  /// The color of the bar within the track. Falls back to [Colors.white] or
  /// [Colors.black] depending on the current [CupertinoThemeData.brightness].
  final Color? barColor;

  /// The border radius of the bar within the track. Should be half of
  /// [trackBorderRadius].
  final BorderRadiusGeometry? barBorderRadius;

  /// Whether to render a knob at the end of the indicator, making it look like
  /// a classic AA battery.
  final bool withKnob;

  /// An optional widget to display in the middle of the battery indicator.
  final Widget? icon;

  /// The color of the [icon] outline. Defaults to [Colors.white].
  final Color? iconOutline;

  /// The size of the outline around [icon]. Defaults to 0.0.
  final double? iconOutlineBlur;

  const BatteryIndicator({
    super.key,
    required this.value,
    this.trackHeight = defaultTrackHeight,
    this.trackPadding = defaultTrackPadding,
    this.trackColor,
    this.trackBorderColor,
    this.trackBorderRadius,
    this.trackAspectRatio = defaultAspectRatio,
    this.barColor,
    this.barBorderRadius,
    this.withKnob = true,
    this.icon,
    this.iconOutline,
    this.iconOutlineBlur,
  })  : assert(value >= 0 && value <= 1, "The value must be in the range [0, 1]"),
        assert(trackHeight / 2 > trackPadding,
            "Track height cannot be smaller than twice the padding."),
        assert(trackPadding >= 0, "Padding must be 0 or greater"),
        assert(trackAspectRatio >= 1,
            "Track aspect ratio must be 1 or greater. Use a Transform.rotate widget to make the indicator vertical.");

  @override
  Widget build(BuildContext context) {
    final track = _buildTrack(context);

    if (!withKnob) return track;

    final knob = _buildKnob(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        track,
        knob,
      ],
    );
  }

  Widget _buildKnob(BuildContext context) {
    final double knobHeight = trackHeight / 3;
    final double knobWidth = knobHeight / 2;
    final knobRadii = BorderRadius.only(
      topRight: Radius.circular(knobWidth),
      bottomRight: Radius.circular(knobWidth),
    );
    final borderColor = _getCurrentBorderColor(context);

    return Padding(
      padding: EdgeInsets.only(left: trackPadding / 2),
      child: Container(
        width: knobWidth,
        height: knobHeight,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: knobRadii,
        ),
      ),
    );
  }

  Widget _buildTrack(BuildContext context) {
    final borderRadius = trackBorderRadius ?? BorderRadius.circular(3.0);
    final borderColor = _getCurrentBorderColor(context);
    final width = trackHeight * trackAspectRatio;

    final bar = _buildBar(context, width);

    final children = [bar];

    final icon = this.icon;
    if (icon != null) {
      final outlineColor = iconOutline ?? Colors.white;
      final outlineSize = iconOutlineBlur ?? 0.0;

      children.add(
        Center(
          child: IconTheme(
            data: IconThemeData(
              color: trackColor,
              shadows: <Shadow>[
                Shadow(
                  color: outlineColor,
                  blurRadius: outlineSize,
                  offset: const Offset(1, 1),
                ),
                Shadow(
                  color: outlineColor,
                  blurRadius: outlineSize,
                  offset: const Offset(-1, -1),
                ),
                Shadow(
                  color: outlineColor,
                  blurRadius: outlineSize,
                  offset: const Offset(-1, 1),
                ),
                Shadow(
                  color: outlineColor,
                  blurRadius: outlineSize,
                  offset: const Offset(1, -1),
                )
              ],
            ),
            child: icon,
          ),
        ),
      );
    }

    return Container(
      height: trackHeight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: borderColor),
        color: trackColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(trackPadding),
        child: Stack(children: children),
      ),
    );
  }

  Color _getCurrentBorderColor(BuildContext context) {
    return trackBorderColor ??
        (CupertinoTheme.brightnessOf(context) == Brightness.light
                ? Colors.black
                : Colors.white)
            .withOpacity(0.5);
  }

  Widget _buildBar(BuildContext context, double trackWidth) {
    final width = (trackWidth - trackPadding * 2.0) * value;
    final borderRadius = barBorderRadius ?? BorderRadius.circular(1.5);
    final currentColor = _getCurrentBarColor(context);

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: currentColor,
      ),
    );
  }

  Color _getCurrentBarColor(BuildContext context) {
    return barColor ??
        (CupertinoTheme.brightnessOf(context) == Brightness.light
            ? Colors.black
            : Colors.white);
  }
}
