import 'package:flutter/material.dart';


class IconWrapper extends StatelessWidget {
  const IconWrapper(
      {super.key,
      required this.child,
      this.radius = 18.0,
      this.onTap,
      this.backgroundColor = Colors.transparent,
      this.isMini = false});
  final Widget child;
  final double radius;
  final void Function()? onTap;
  final Color backgroundColor;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(isMini ? 20 : 50),
        onTap: onTap,
        child: CircleAvatar(
            backgroundColor: backgroundColor, radius: radius, child: child),
      ),
    );
  }
}
