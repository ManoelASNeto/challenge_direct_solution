import 'package:flutter/material.dart';

extension GradientContainerExtension on BuildContext {
  BoxDecoration get linearGradientBox => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2DB08D),
            Color(0xFF7EC873),
            Color(0xFFF5D74F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
}
