import 'package:flutter/material.dart';

final heroCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withValues(alpha: .12),
          offset: const Offset(0, 27),
          blurRadius: 27,
          spreadRadius: .5)
    ]);

final heroNav = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50.0),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withValues(alpha: .23),
          offset: const Offset(2, 18),
          blurRadius: 18,
          spreadRadius: .5)
    ]);

const kToken = "";
