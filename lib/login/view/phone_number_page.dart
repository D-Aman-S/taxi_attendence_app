import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';
import 'package:taxi_attendence_app/components/custom_input.dart';
import 'package:taxi_attendence_app/components/custom_spaces.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/login/cubit/login_state.dart';
import 'package:taxi_attendence_app/login/login.dart';
import 'package:taxi_attendence_app/utilities/color_constants.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneNumberPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<PhoneNumberPage> {
  @override
  PhoneNumberPage get widget => super.widget;
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showError = false;
  String errorMessage = "";
  @override
  void initState() {
    print("reached");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const HeightSpace(27),
                    SizedBox(
                      height: 31,
                      width: 72,
                      child: Image.asset("assets/logo.png"),
                    ),
                    const HeightSpace(21),
                    Text(
                      "For our champions, our drivers",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: fontColor),
                    ),
                    const HeightSpace(64),
                    SizedBox(
                      height: 295,
                      width: 340,
                      child: Image.asset("assets/home.png"),
                    ),
                    const HeightSpace(55),
                    Semantics(
                      label: "Username",
                      child: CustomInput(
                        label: "Enter Phone Number",

                        controller: phoneNumberController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        textInputType: TextInputType.number,
                        // maxLength: 10,
                        onTextChange: (String s) {},
                      ),
                    ),
                    const HeightSpace(5),
                    if (showError)
                      Row(
                        children: [
                          Text(
                            errorMessage,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.red),
                          ),
                          const Spacer()
                        ],
                      )
                  ],
                )),
          ),
        ),
        bottomSheet: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (mounted) {
              if (state is LoginLoadingState) {
                LoadingScreen().show(context: context);
              } else if (state is LoginCodeSentState) {
                LoadingScreen().hide();
              } else if (state is LoginErrorState) {
                LoadingScreen().hide();
                print(state.error);
              } else {
                LoadingScreen().hide();
              }
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Semantics(
                label: "Submit",
                child: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                phoneNumberController.text.length == 10) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              BlocProvider.of<LoginCubit>(context)
                                  .logInWithPhoneNumber(
                                      phoneNumberController.text);
                            } else {
                              setState(() {
                                showError = true;
                                errorMessage =
                                    "Please enter a valid phone number";
                              });
                            }
                          },
                          displayText: "Proceed",
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: Image.asset("assets/doublearrow.png"),
                            ),
                          ),
                          textSize: 20,
                          height: 60,
                          borderRadius: 15,
                          color1: fontColor,
                          color2: fontColor,
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      )),
    );
  }
}
