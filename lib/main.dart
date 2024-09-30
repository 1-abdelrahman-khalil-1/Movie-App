import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Data/cubit.dart';
import 'Features/Presentation/Home_page/home.dart';


void main() {
  runApp(const MainApp());
}

List saved = [];

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Movies_Cubit()..get_latest()..get_popular()..get_upcoming()..get_top_rated(),
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