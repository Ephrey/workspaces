import 'package:flutter/material.dart';

class CustomScaleAnimation extends StatefulWidget {
  final Widget child;
  final double begin;

  CustomScaleAnimation({Key key, this.child, this.begin}) : super(key: key);

  @override
  CustomScaleAnimationState createState() => CustomScaleAnimationState();
}

class CustomScaleAnimationState extends State<CustomScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _animation = Tween(begin: 1.0, end: 1.13).animate(
      CurvedAnimation(
        curve: Curves.easeInOutBack,
        parent: _controller,
      ),
    );

    _controller.forward().whenComplete(() => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
