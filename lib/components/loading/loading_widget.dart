import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  static Page<void> page() => const MaterialPage<void>(child: Loading());

  @override
  Widget build(BuildContext context) {
    print("loading triggered");
    return const Material(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
      ),
    );
  }
}
