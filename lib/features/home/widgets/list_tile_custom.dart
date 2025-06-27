import 'package:challenge_direct_solution/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ListTileCustom({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        leading: Icon(icon, color: context.greenAceent),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap);
  }
}
