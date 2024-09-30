import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Core/utilities/bottomnavigation.dart';
import 'package:movie_app/Features/Presentation/Home_page/Widgets/Displaypictures.dart';
import 'package:movie_app/Features/Presentation/Home_page/Widgets/Headerofdisplay.dart';
import 'package:movie_app/Features/Presentation/Home_page/Widgets/TopContainer.dart';
import '../../Data/cubit.dart';

class Home_screen extends StatelessWidget {
  Home_screen({super.key, required this.i});
  int i;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Movies_Cubit, Movies_state>(
      builder: (context, state) {
       
        if (state is Loading) {
          return const SafeArea(
              child: Scaffold( 
                  backgroundColor: Color.fromARGB(255, 10, 6, 46),
                  body: SpinKitFadingFour(
                    color: Colors.white,
                    size: 60,
                  )));
        } else if (state is Success) {
          return SafeArea(
              child: Scaffold(
                  bottomNavigationBar: Bottomnavigation(i: i),
                  backgroundColor: const Color.fromARGB(255, 10, 6, 46),
                  body: ListView(children: [
                    const Topcontainer(),
                    const Headerofdisplay(
                        first: "Most Popular", second: "See all"),
                    Displaypictures(x: state.popular_posters),
                    const Headerofdisplay(
                        first: "Latest Movies", second: "See all"),
                    Displaypictures(x: state.latest_posters),
                    const Headerofdisplay(
                        first: "Upcoming Movies", second: "See all"),
                    Displaypictures(x: state.upcoming_posters)
                  ])));
        } else {
          return const SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 10, 6, 46),
                  body: Center(
                      child: Text(
                    "Error",
                    style: TextStyle(fontSize: 50, color: Colors.white70),
                  ))));
        }
      },
    );
  }
}