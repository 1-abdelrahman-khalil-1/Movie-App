import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 10, 6, 46),
          body: SpinKitFadingFour(
            color: Colors.white,
            size: 60,
          )),
    );
  }
}