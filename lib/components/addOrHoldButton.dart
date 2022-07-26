import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TapOrHoldButton extends StatefulWidget {
  /// Update callback
  final VoidCallback onUpdate;

  /// Minimum delay between update events when holding the button
  final int minDelay;

  /// Initial delay between change events when holding the button
  final int initialDelay;

  /// Number of steps to go from [initialDelay] to [minDelay]
  final int delaySteps;

  /// Icon on the button
  final String assetPath;

  const TapOrHoldButton(
      {Key? key,
      required this.onUpdate,
      this.minDelay = 80,
      this.initialDelay = 300,
      this.delaySteps = 5,
      required this.assetPath})
      : assert(minDelay <= initialDelay,
            "The minimum delay cannot be larger than the initial delay"),
        super(key: key);

  @override
  _TapOrHoldButtonState createState() => _TapOrHoldButtonState();
}

class _TapOrHoldButtonState extends State<TapOrHoldButton> {
  /// True if the button is currently being held
  bool _holding = false;

  @override
  Widget build(BuildContext context) {
    var shape = CircleBorder();
    return Material(
      color: Theme.of(context).dividerColor,
      shape: shape,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(widget.assetPath),
        ),
        onTap: () => _stopHolding(),
        onTapDown: (_) => _startHolding(),
        onTapCancel: () => _stopHolding(),
        customBorder: shape,
      ),
    );
  }

  void _startHolding() async {
    // Make sure this isn't called more than once for
    // whatever reason.
    if (_holding) return;
    _holding = true;

    // Calculate the delay decrease per step
    final step =
        (widget.initialDelay - widget.minDelay).toDouble() / widget.delaySteps;
    var delay = widget.initialDelay.toDouble();

    while (_holding) {
      widget.onUpdate();
      await Future.delayed(Duration(milliseconds: delay.round()));
      if (delay > widget.minDelay) delay -= step;
    }
  }

  void _stopHolding() {
    _holding = false;
  }
}
