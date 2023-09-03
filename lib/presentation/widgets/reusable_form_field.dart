import 'package:flutter/material.dart';

class ReusableFormField extends StatelessWidget {
  const ReusableFormField({
    super.key,
    required this.controller,
    this.obscureText = true,
    required this.validator,
    this.suffixIcon,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
