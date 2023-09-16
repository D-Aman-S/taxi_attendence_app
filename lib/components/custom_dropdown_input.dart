import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> itemList;
  final String? initialValue;
  final Function(String) onTextChange;
  final String label;
  final double? width;
  const CustomDropdown(
      {Key? key,
      required this.itemList,
      this.initialValue,
      required this.onTextChange,
      required this.label,
      this.width})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? dropDownValue = "";
  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 26,
      width: widget.width,
      decoration: const BoxDecoration(
          color: const Color(0xffDCF4F7),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropDownValue,
          iconEnabledColor: const Color(0xff004a5d),
          iconDisabledColor: Colors.grey,
          dropdownColor: const Color(0xffDCF4F7),
          style:
              GoogleFonts.inter(color: const Color(0xff004A5D), fontSize: 13),
          icon: const Icon(Icons.expand_more),
          elevation: 12,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue!;
            });
            widget.onTextChange(dropDownValue!);
          },
          selectedItemBuilder: (BuildContext context) {
            return widget.itemList.map<Widget>((String item) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xff004A5D),
                  ),
                ),
              );
            }).toList();
          },
          items: widget.itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.inter(
                    color: const Color(0xff004A5D), fontSize: 13),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
