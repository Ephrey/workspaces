import 'package:flutter/material.dart';

class CustomPositionAnimation extends StatefulWidget {
  final Widget child;
  final double beginLeft;
  final double beginTop;
  final double beginRight;
  final double beginBottom;

  final double endLeft;
  final double endTop;
  final double endRight;
  final double endBottom;

  final Curve curve;

  CustomPositionAnimation({
    Key key,
    @required this.child,
    this.beginLeft: 0.0,
    this.beginTop: 0.0,
    this.beginRight: 0.0,
    this.beginBottom: 0.0,
    this.endLeft: 0.0,
    this.endTop: 0.0,
    this.endRight: 0.0,
    this.endBottom: 0.0,
    this.curve: Curves.easeOutSine,
  }) : super(key: key);

  @override
  CustomPositionAnimationState createState() => CustomPositionAnimationState();
}

class CustomPositionAnimationState extends State<CustomPositionAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<RelativeRect> _rectAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _rectAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        widget.beginLeft,
        widget.beginTop,
        widget.beginRight,
        widget.beginBottom,
      ),
      end: RelativeRect.fromLTRB(
        widget.endLeft,
        widget.endTop,
        widget.endRight,
        widget.beginBottom,
      ),
    ).animate(
      CurvedAnimation(
        curve: widget.curve,
        parent: _controller,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: _rectAnimation,
      child: widget.child,
    );
  }
}
