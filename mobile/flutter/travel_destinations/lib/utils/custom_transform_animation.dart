import 'package:flutter/material.dart';

class CustomTransformAnimation extends StatefulWidget {
  final Widget child;

  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;

  final double translationX;
  final double translationY;
  final double translationZ;

  final double intervalBegin;
  final double intervalEnd;

  CustomTransformAnimation({
    Key key,
    this.child,
    this.duration: const Duration(milliseconds: 600),
    this.begin: -1.0,
    this.end: 0.0,
    this.curve: Curves.easeInOutQuart,
    this.translationX: 0.0,
    this.translationY: 0.0,
    this.translationZ: 0.0,
    this.intervalBegin: 0.0,
    this.intervalEnd: 1.0,
  }) : super(key: key);

  @override
  CustomTransformAnimationState createState() =>
      CustomTransformAnimationState();
}

class CustomTransformAnimationState extends State<CustomTransformAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween(begin: widget.begin, end: widget.end).animate(
      CurvedAnimation(
        curve: Interval(
          widget.intervalBegin,
          widget.intervalEnd,
          curve: widget.curve,
        ),
        parent: _controller,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Transform Function(BuildContext, Widget) _builder = (context, child) {
      var translationX = (widget.translationX != .0)
          ? _animation.value * widget.translationX
          : .0;

      var translationY = (widget.translationY != .0)
          ? _animation.value * widget.translationY
          : .0;

      var translationZ = (widget.translationZ != .0)
          ? _animation.value * widget.translationZ
          : .0;

      return Transform(
        transform: Matrix4.translationValues(
          translationX,
          translationY,
          translationZ,
        ),
        child: child,
      );
    };

    return AnimatedBuilder(
      child: widget.child,
      animation: _animation,
      builder: _builder,
    );
  }
}
