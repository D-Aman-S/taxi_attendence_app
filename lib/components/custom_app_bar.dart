import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String appBarTitle;
  final bool? showBackButton;
  final Widget? endButton;
  final void Function()? onPressed;
  const CustomAppBar({
    Key? key,
    required this.appBarTitle,
    this.showBackButton,
    this.endButton,
    this.onPressed,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient:
            LinearGradient(colors: [Color(0xffB9F1FF), Color(0xffA2E0CE)]),
      ),
      child: AppBar(
        leadingWidth: 105,
        title: Text(
          widget.appBarTitle,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        shadowColor: const Color(0x08000000),
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: SizedBox(
            height: 31,
            width: 71,
            child: Image.asset("assets/logo.png"),
          ),
        ),
        elevation: 3,
        actions: widget.endButton != null ? [widget.endButton!] : null,
      ),
    );
  }
}
