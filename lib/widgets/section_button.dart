import 'package:flutter/material.dart';

class SectionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent.shade700,
        ),
        onPressed: onTap,
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
