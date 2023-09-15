import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_attendence_app/app/bloc/app_bloc.dart';
import 'package:taxi_attendence_app/components/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text("asasas"),
          ),
          CustomButton(
              onPressed: () {
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              displayText: "logout")
        ],
      ),
    );
  }
}
