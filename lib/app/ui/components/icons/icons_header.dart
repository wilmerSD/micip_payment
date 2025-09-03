import 'package:flutter/material.dart';

class IconsHeader extends StatelessWidget {
  const IconsHeader(this.icon, {super.key});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.white, size: 20);
  }
}
