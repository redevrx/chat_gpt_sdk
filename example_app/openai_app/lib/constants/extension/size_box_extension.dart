import 'package:flutter/material.dart';

extension SizeBoxExtension on double {
  SizedBox toHeight({double height = 1.0}) {
    return SizedBox(height: this * height);
  }

  SizedBox toWidth() {
    return SizedBox(width: this);
  }
}
