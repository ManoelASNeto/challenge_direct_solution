import 'package:flutter/material.dart';

class LogoCustom extends StatelessWidget {
  const LogoCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image.asset(
            'assets/logo_tokio.png',
            height: 50,
            width: 50,
          ),
          Column(
            children: [
              Text(
                'Tokio Marine',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Seguradora',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
