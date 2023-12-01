import 'package:flutter/material.dart';

extension Extension on Widget {
  Widget addGestureDetection(VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: this,
    );
  }

  Widget wrapPadding(EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }
}

extension NumExtension on num {
  Widget height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget width() {
    return SizedBox(
      width: toDouble(),
    );
  }

  Widget divider({Color color = Colors.grey}) {
    return Container(
      color: color,
      height: toDouble(),
    );
  }
}
