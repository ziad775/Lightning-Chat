import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {super.key,
      required this.controller,
      required this.textInputType,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      required this.onChanged,
      this.isPassword = false});
  final TextEditingController controller;
  final TextInputType textInputType;
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final ValueChanged onChanged;
  final bool isPassword; // Default to false, can be set to true if needed

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          style: const TextStyle(
            // Style for the text the user types
            fontSize: 18.0,
            color: Colors.black,
          ),
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            // Style for the hint text
            hintStyle: TextStyle(
              color: Colors.grey[600], // A nice shade of grey
              fontSize: 18.0, // Match your input text size or adjust as needed
            ),
            prefixIcon: prefixIcon,
            floatingLabelStyle: TextStyle(
              color: Colors
                  .blueAccent, // Change to blue accent when focused/floating
              fontSize:
                  16.0, // You might want a slightly different size for the floating label
              // fontWeight: FontWeight.bold, // Optionally make it bold
            ),
            // Default border when the field is not focused
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.grey[400]!, // Or any other default color
                width: 1.0,
              ),
            ),
            // Border when the field is focused (clicked/typing)
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.blueAccent, // Your desired blue accent color
                width: 2.0, // Make it slightly thicker when focused, if desired
              ),
            ),
            // Color when focused
            // You might also want to define other border states like errorBorder, focusedErrorBorder
            // For example:
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
          ),
          onChanged: onChanged,
        ));
  }
}
