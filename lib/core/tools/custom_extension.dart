import 'package:flutter/material.dart';

extension NumExtention on int {
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
}

Expanded hdExpanded = Expanded(
  child: 0.ph,
);
