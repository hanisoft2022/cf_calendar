import 'package:flutter/material.dart';

class WCustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isExpands;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String? initialValue;
  final String? suffixText;

  const WCustomTextFormField({
    super.key,
    required this.hintText,
    this.isExpands = false,
    required this.validator,
    required this.onSaved,
    this.initialValue,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: validator,
      expands: isExpands,
      maxLines: isExpands ? null : 1,
      minLines: isExpands ? null : 1,
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        suffixText: suffixText,
        filled: true,
        fillColor: Colors.grey[400],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      cursorColor: Colors.grey,
    );
  }
}
