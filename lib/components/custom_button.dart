import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

class CustomButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String displayText;
  final Color? color1;
  final Color? color2;
  final Color? labelColor;
  final double? height;
  final double? width;
  final double? textSize;
  final bool? isDisable;
  final double? borderRadius;
  final Widget icon;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.displayText,
      this.labelColor,
      this.height,
      this.isDisable,
      this.textSize,
      this.width,
      this.color1,
      this.color2,
      this.borderRadius,
      this.icon = const SizedBox(
        height: 0,
        width: 0,
      )})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: widget.isDisable == true
              ? const LinearGradient(colors: [
                  Colors.grey,
                  Colors.grey,
                ])
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      widget.color1 ?? themeGradientColor1,
                      widget.color2 ?? themeGradientColor2,
                    ]),
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadius ?? 5)),
        ),
        height: widget.height ?? 48,
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          onPressed: widget.onPressed,
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            //Layoout buider so that i  could make the text size dynamic
            double fontSize = constraints.maxHeight * 0.4;
            double fontSizeByWidth = constraints.maxWidth * 0.3;
            fontSize = min(fontSizeByWidth,
                fontSize); //getting fontsize based on width and height
            fontSize = max(9, fontSize); //setting minimum fontsize to be as 9
            fontSize =
                min(18, fontSize); // setting maximum fontsize to 18 throughout
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                Text(widget.displayText,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: widget.labelColor ??
                          Colors
                              .white, //making buttonn text dynamic so that it doesnt overflows
                      fontSize: widget.textSize != null
                          ? min(widget.textSize!, fontSize)
                          : fontSize,
                    )),
              ],
            );
          }),
        ));
  }
}
