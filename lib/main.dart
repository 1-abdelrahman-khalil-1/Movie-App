import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/cubit.dart';
import 'package:movie_app/Screens/Home_page/home.dart';

void main() {
  runApp(const MainApp());
}

List saved = [];

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Movies_Cubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home_screen(
            i : 0
          )
          ),
    );
  }
}

/*
1 10
-8
19
-8 1 10
10 1 -8
1 10 
*/