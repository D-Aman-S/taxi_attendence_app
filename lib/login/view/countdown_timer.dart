import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/login/cubit/login_cubit.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;
  @override
  initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        if (secondsRemaining != 0) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          setState(() {
            enableResend = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "00:$secondsRemaining",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color.fromARGB(255, 89, 89, 89),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: enableResend ? _resendCode : null,
          child: const Text(
            "Resend OTP",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  void _resendCode() async {
    LoadingScreen().show(context: context);
    final cubit = BlocProvider.of<LoginCubit>(context);
    cubit.logInWithPhoneNumber(cubit.phoneNumber);
    LoadingScreen().hide();
    if (mounted) {
      setState(() {
        secondsRemaining = 60;
        enableResend = false;
      });
    }
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}
