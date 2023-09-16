import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:taxi_attendence_app/components/custom_dropdown_input.dart';
import 'package:taxi_attendence_app/components/custom_spaces.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

class EarningsContainer extends StatelessWidget {
  const EarningsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Stack(
        children: [
          Positioned(
            top: 67,
            child: Container(
              height: 215,
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [themeGradientColor1, themeGradientColor2],
                  ),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const HeightSpace(25),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Employee Code",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xff7D9298)),
                            ),
                            const HeightSpace(2),
                            Text(
                              "ZE-12345",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color(0xff000000)),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clients",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xff7D9298)),
                            ),
                            const HeightSpace(2),
                            Text(
                              "Big Basket, Zomato",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color(0xff000000)),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  const HeightSpace(30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hub Name",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xff7D9298)),
                            ),
                            const HeightSpace(2),
                            Text(
                              "Centre xyz \nArea name",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color(0xff000000)),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recruiter",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xff7D9298)),
                            ),
                            const HeightSpace(2),
                            Text(
                              "Recruiter Name",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: const Color(0xff000000)),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 95,
            padding: const EdgeInsets.only(left: 20, top: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeGradientColor1,
                    themeGradientColor2,
                  ]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You have Earned",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      const HeightSpace(12),
                      SizedBox(
                        width: 111,
                        child: CustomDropdown(
                            itemList: const ["This Week", "This Month"],
                            onTextChange: (val) {},
                            label: '',
                            initialValue: "This Week"),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 66,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 35,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Spacer(),
                            Text(
                              '₹',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            const WidthSpace(2),
                            Text(
                              '0',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 34,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      const HeightSpace(6),
                      SizedBox(
                        width: 66,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'View More',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const WidthSpace(18)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
