import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_attendence_app/components/custom_spaces.dart';

class BottomCards extends StatelessWidget {
  const BottomCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 140,
          padding: const EdgeInsets.only(top: 17),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(14, 34, 39, 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2))
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/taxi.png")),
                ),
              ),
              const HeightSpace(6),
              Text(
                "KA 64, 1234",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff0E2227)),
              ),
              const HeightSpace(6),
              Text(
                "Company, Model Name",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xff7D9298)),
              ),
            ],
          ),
        )),
        const WidthSpace(8),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 17),
          height: 140,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(14, 34, 39, 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2))
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/call.png")),
                ),
              ),
              const HeightSpace(14),
              Text(
                "Contact Supervisor",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff0E2227)),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
