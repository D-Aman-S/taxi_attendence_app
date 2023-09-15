import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/components/loading/loading_widget.dart';
import 'package:taxi_attendence_app/home/view/home.dart';
import 'package:taxi_attendence_app/login/cubit/login_cubit.dart';
import 'package:taxi_attendence_app/login/view/countdown_timer.dart';

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
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            LoadingScreen().show(context: context);
          } else if (state is LoginLoggedInState) {
            LoadingScreen().hide();
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
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
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: 420,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(5, 25, 5, 25),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/logo.png")),
                      Container(
                        width: 216.00,
                        margin: const EdgeInsets.only(left: 46, right: 46),
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Please enter OTP sent\nto ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: BlocProvider.of<LoginCubit>(context)
                                        .phoneNumber,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 46, top: 60, right: 45),
                        child: Semantics(
                          label: "OTP",
                          child: Container(
                              width: 360,
                              height: 80,
                              padding: const EdgeInsets.all(5),
                              child: Pinput(
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                controller: otpController,
                                length: 6,
                                submittedPinTheme: submittedPinTheme,
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) => print(pin),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 420,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 46, top: 23, right: 45),
                            child: CountDownTimer(),
                          ),
                        ),
                      ),
                      Semantics(
                        label: "Submit",
                        child: SizedBox(
                            width: 420,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginCubit>(context)
                                        .verifyOtp(otpController.text);
                                  },
                                  displayText: "Verify OTP"),
                            )),
                      ),
                    ],
                  ),
                )),
          );
        },
      )),
    );
  }
}
