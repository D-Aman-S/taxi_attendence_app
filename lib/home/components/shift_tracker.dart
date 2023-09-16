import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

class ShiftTracker extends StatelessWidget {
  const ShiftTracker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(20),
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
          Row(
            children: [
              Text(
                "Shift Tracker",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: fontColor),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                "From: ",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff8399A3)),
              ),
              Text(
                "09:00",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff004A5D)),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TimerCountdown(
                spacerWidth: 0,
                enableDescriptions: false,
                timeTextStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: fontColor),
                format: CountDownTimerFormat.hoursMinutesSeconds,
                endTime: DateTime.now().add(
                  const Duration(
                    hours: 2,
                    minutes: 27,
                    seconds: 34,
                  ),
                ),
                onEnd: () {
                  print("Timer finished");
                },
              ),
              const Spacer(),
              Text(
                "To: ",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff8399A3)),
              ),
              Text(
                "06:00",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xff004A5D)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
