import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';
import 'package:taxi_attendence_app/components/custom_input.dart';
import 'package:taxi_attendence_app/components/loading/loading_screen.dart';
import 'package:taxi_attendence_app/login/cubit/login_cubit.dart';
import 'package:taxi_attendence_app/login/cubit/login_state.dart';
import 'package:taxi_attendence_app/login/login.dart';
import 'package:taxi_attendence_app/utilities/validate.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
          body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(5, 25, 5, 25),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset("assets/call.png")),
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Login to access your account',
                      style: TextStyle(fontSize: 15),
                    )),
                Semantics(
                  label: "Username",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomInput(
                      label: "Phone Number",
                      validator: Validate.phoneNumber,
                      controller: phoneNumberController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputType: TextInputType.number,
                      maxLength: 10,
                      onTextChange: (String s) {},
                    ),
                  ),
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (mounted) {
                      if (state is LoginLoadingState) {
                        LoadingScreen().show(context: context);
                      } else if (state is LoginCodeSentState) {
                        LoadingScreen().hide();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: context.read<LoginCubit>(),
                                      child: const OtpPage(),
                                    )));
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Semantics(
                        label: "Submit",
                        child: CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                BlocProvider.of<LoginCubit>(context)
                                    .logInWithPhoneNumber(
                                        phoneNumberController.text);
                              }
                            },
                            displayText: "Login"),
                      ),
                    );
                  },
                ),
              ],
            )),
      ))),
    );
  }
}
