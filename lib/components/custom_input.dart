// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

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
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: fontColor,
              height: 1.1),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [themeGradientColor1, themeGradientColor2],
              ),
              width: 1,
            ),
            color: Colors.white, // Background color
          ),
          child: TextFormField(
            readOnly: readOnly ?? false,
            style: const TextStyle(overflow: TextOverflow.fade),
            controller: controller,
            validator: validator,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            obscureText: obscureText ?? false,
            initialValue: initialValue,
            maxLength: maxLength,
            onChanged: (value) {
              onTextChange(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, top: 9.8),
                child: Text(' +91 | ',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFC4C4C4),
                    )),
              ),
              hintText: '  Phone Number', // Placeholder text
              hintStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xFFC4C4C4)),

              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.8, bottom: 13.7),
            ),
          ),
        ),
      ],
    );
  }
}
