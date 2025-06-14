import 'package:flutter/material.dart';

/// Generic widget that slides in from an edge when [controller] animates.
class EdgeMenu extends StatelessWidget {
  final Alignment alignment;
  final AnimationController controller;
  final double width;
  final Widget child;

  const EdgeMenu({
    Key? key,
    required this.alignment,
    required this.controller,
    required this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(
      begin: alignment == Alignment.centerLeft
          ? const Offset(-1, 0)
          : const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    return Align(
      alignment: alignment,
      child: SlideTransition(
        position: animation,
        child: Container(
          width: width,
          color: Colors.black87,
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: child,
        ),
      ),
    );
  }
}
