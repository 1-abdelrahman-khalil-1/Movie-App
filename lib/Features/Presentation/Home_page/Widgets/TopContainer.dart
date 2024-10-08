import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/utilities/pushNavigator.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Screen2/screen2.dart';

class Topcontainer extends StatefulWidget {
  const Topcontainer({super.key});

  @override
  State<Topcontainer> createState() => _TopcontainerState();
}

class _TopcontainerState extends State<Topcontainer> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Movies_Cubit, Movies_state>(builder: (context, state) {
      if (state is Success) {
        return Stack(
          children: [
            CarouselSlider(
                items: state.toprated_posters.map((posters) {
                  return GestureDetector(
                      onTap: () {
                        BlocProvider.of<Movies_Cubit>(context)
                            .get_movie(posters[1]);
                            BlocProvider.of<Movies_Cubit>(context)
                            .get_actors(posters[1]);
                            BlocProvider.of<Movies_Cubit>(context)
                            .get_similar(posters[1]);
                        PushNavigator.navigateTo(
                            context, ShowSelected(id: posters[1]));
                      },
                      child: posters[0]);
                }).toList(),
                options: CarouselOptions(
                    onPageChanged: (x, reason) {
                      setState(() {
                        i = x;
                      });
                    },
                    autoPlay: true,
                    height: 350,
                    viewportFraction: 1,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1100),
                    autoPlayInterval: const Duration(seconds: 5))),
            Container(
              margin: const EdgeInsets.only(top: 300),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 315),
                child: DotsIndicator(
                  dotsCount: state.toprated_posters.isEmpty
                      ? 1
                      : state.toprated_posters.length,
                  position: i,
                  decorator: DotsDecorator(
                      activeColor: Colors.red,
                      activeSize: const Size(18, 8),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            )
          ],
        );
      } else {
        return const Text("Error");
      }
    });
  }
}
