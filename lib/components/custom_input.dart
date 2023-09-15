// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final bool? obscureText;
  final Function(String) onTextChange;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int? maxLength;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final String? initialValue;
  final Color? fillColor;
  final String? placeholder;

  const CustomInput(
      {Key? key,
      required this.label,
      this.obscureText,
      required this.onTextChange,
      this.maxLines,
      this.controller,
      this.validator,
      this.textInputType,
      this.maxLength,
      this.inputFormatters,
      this.prefixIcon,
      this.readOnly,
      this.initialValue,
      this.fillColor,
      this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: readOnly ?? false,
          style: const TextStyle(overflow: TextOverflow.fade),
          controller: controller,
          validator: validator,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          obscureText: obscureText ?? false,
          initialValue: initialValue,
          maxLines: maxLines ?? 1,
          onChanged: (value) {
            onTextChange(value);
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14),
            hintText: placeholder,
            prefixIcon: prefixIcon,
            helperText: " ",
            filled: fillColor != null ? true : false,
            fillColor: fillColor,
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Color(0xffdadada),
              ),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(
          height: 2,
        )
      ],
    );
  }
}
