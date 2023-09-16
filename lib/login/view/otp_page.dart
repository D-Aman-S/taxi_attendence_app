import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';
import 'package:taxi_attendence_app/components/custom_spaces.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/components/loading/loading_widget.dart';
import 'package:taxi_attendence_app/home/view/home.dart';
import 'package:taxi_attendence_app/login/cubit/login_cubit.dart';
import 'package:taxi_attendence_app/login/view/countdown_timer.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

import '../cubit/login_state.dart';

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  _OtpPageState();
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;
  @override
  OtpPage get widget => super.widget;
  TextEditingController otpController = TextEditingController();
  // bool showError = false;
  bool showLoading = false;
  String errorMessage = "";
  final defaultPinTheme = PinTheme(
    height: 62,
    constraints: const BoxConstraints(minWidth: 53, maxWidth: 63),
    padding: const EdgeInsets.only(left: 4, right: 4),
    textStyle: GoogleFonts.roboto(
        fontWeight: FontWeight.w400, fontSize: 16, color: fontColor),
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
  );

  @override
  Widget build(BuildContext context) {
    // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    //   border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    //   borderRadius: BorderRadius.circular(8),
    // );

    // final submittedPinTheme = defaultPinTheme.copyWith(
    //   decoration: defaultPinTheme.decoration?.copyWith(
    //     color: Color.fromRGBO(234, 239, 243, 1),
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              LoadingScreen().show(context: context);
            } else if (state is LoginLoggedInState) {
              LoadingScreen().hide();
            } else if (state is LoginErrorState) {
              otpController.text = "";
              LoadingScreen().hide();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Invalid Otp"),
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 800),
              ));
            } else {
              LoadingScreen().hide();
            }
          },
          builder: (context, state) {
            if (state is LoginLoggedInState) {
              return const Loading();
            }
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        const HeightSpace(27),
                        SizedBox(
                          height: 31,
                          width: 72,
                          child: Image.asset("assets/logo.png"),
                        ),
                        const HeightSpace(10),
                        SizedBox(
                          height: 295,
                          width: 340,
                          child: Image.asset("assets/otp_screen_image.png"),
                        ),
                        const HeightSpace(31),
                        Row(
                          children: [
                            Text(
                              "Enter OTP",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: fontColor),
                            ),
                            const Spacer()
                          ],
                        ),
                        const HeightSpace(10),
                        Row(
                          children: [
                            Text(
                              "Sent to ${context.read<LoginCubit>().phoneNumberval}",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: fontColor),
                            ),
                            const Spacer(),
                            const CountDownTimer(),
                          ],
                        ),
                        HeightSpace(10),
                        Semantics(
                          label: "OTP",
                          child: Pinput(
                            defaultPinTheme: defaultPinTheme,
                            // focusedPinTheme: focusedPinTheme,
                            controller: otpController,
                            length: 6,
                            // submittedPinTheme: submittedPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Semantics(
            label: "Submit",
            child: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    CustomButton(
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context)
                            .verifyOtp(otpController.text);
                      },
                      displayText: "Verify OTP",
                      textSize: 20,
                      height: 60,
                      borderRadius: 15,
                      color1: fontColor,
                      color2: fontColor,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
