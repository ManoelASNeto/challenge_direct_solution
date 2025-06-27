import 'package:challenge_direct_solution/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerCustom extends StatelessWidget {
  final String label;
  final IconData icon;
  final double sizewidth;
  final double sizeheight;

  const ContainerCustom({
    super.key,
    required this.label,
    required this.icon,
    required this.sizewidth,
    required this.sizeheight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizewidth,
      height: sizeheight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: context.backgroundLight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: context.greenAceent,
          ),
          SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
