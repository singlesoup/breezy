import 'package:flutter/material.dart';

class PulsatingCircle extends StatefulWidget {
  final Color color;
  final double paddingSize;

  const PulsatingCircle({this.color,this.paddingSize,});
  @override
  _PulsatingCircleState createState() => _PulsatingCircleState();
}

class _PulsatingCircleState extends State<PulsatingCircle>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animation = Tween(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Ink(
          padding: EdgeInsets.all(widget.paddingSize),
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              for (int i = 1; i <= 3; i++)
                BoxShadow(
                  color: widget.color.withOpacity(animationController.value / 2),
                  spreadRadius: animation.value * i,
                ),
            ],
          ),
        );
      },
    );
  }
}
