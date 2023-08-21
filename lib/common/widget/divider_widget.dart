import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double opacity;
  final double? thinkness;
  final double? indent;
  final double? endIndent;
  final EdgeInsetsGeometry? padding;
  const DividerWidget(
      {this.endIndent,
      this.thinkness,
      this.indent,
      this.padding,
      required this.opacity,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Divider(
        height: 1,
        indent: indent ?? 0,
        endIndent: endIndent ?? 0,
        thickness: thinkness ?? 0,
        color: Theme.of(context).primaryColorLight.withOpacity(opacity),
      ),
    );
  }
}
