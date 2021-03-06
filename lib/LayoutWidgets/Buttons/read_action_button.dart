import 'package:bookifyapp/Design/constants.dart';
import 'package:flutter/material.dart';

class ReadActionButton extends StatefulWidget {
  @override
  _ReadActionButton createState() => _ReadActionButton();
}

class _ReadActionButton extends State<ReadActionButton>
    with SingleTickerProviderStateMixin {
  static const String DEFAULT_TOOLTIP = 'Toggle';
  static const int DEFAULT_DURATION = 500;
  static const double DEFAULT_BEGIN = 0.00;
  static const double DEFAULT_END = 1.00;

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: DEFAULT_DURATION))
      ..addListener(() {
        setState(() {});
      });

    _animateIcon = Tween<double>(begin: DEFAULT_BEGIN, end: DEFAULT_END)
        .animate(_animationController);

    _animateColor = ColorTween(
      begin: kPrimaryLightColor,
      end: kPrimaryLightColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        DEFAULT_BEGIN,
        DEFAULT_END,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      heroTag: UniqueKey(),
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: DEFAULT_TOOLTIP,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
