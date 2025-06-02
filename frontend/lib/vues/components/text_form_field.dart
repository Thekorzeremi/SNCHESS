import 'package:flutter/material.dart';
import 'package:snct/color.dart';

class MyInputField extends StatefulWidget {
  const MyInputField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.secondary,
    this.enabled = true,
  });

  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final Color textColor;
  final Color borderColor;
  final bool enabled;

  @override
  _MyInputFieldState createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      cursorColor: widget.borderColor,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12.0,
        ),
        label: Text(
          widget.label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.textColor),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.controller.text.isNotEmpty && widget.enabled
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  widget.controller.clear();
                  setState(() {});
                },
              )
            : null,
      ),
      onChanged: (text) => setState(() {}),
      style: TextStyle(color: widget.textColor),
    );
  }
}
