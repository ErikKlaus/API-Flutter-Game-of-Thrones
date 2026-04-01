import 'package:flutter/material.dart';

class BilahPencarianKarakter extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const BilahPencarianKarakter({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      cursorColor: const Color(0xFFD4AF37),
      decoration: InputDecoration(
        hintText: 'Cari berdasarkan nama karakter...',
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
        ),
      ),
    );
  }
}
