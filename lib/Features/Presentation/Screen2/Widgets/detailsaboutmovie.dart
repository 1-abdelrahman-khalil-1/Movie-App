import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Core/utilities/loading.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Saved%20Screen/Widgets/Display_pictures.dart';
import 'package:movie_app/Features/Presentation/Screen2/Widgets/aboutcategories.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';



class Detailsaboutmovie extends StatefulWidget {
  const Detailsaboutmovie(
      {super.key,
      required this.language,
      required this.duration,
      required this.rate,
      required this.genre,
      required this.id});
  final List language;
  final int duration, id;
  final double rate;
  final String genre;
  @override
  State<Detailsaboutmovie> createState() => _DetailsaboutmovieState();
}

class _DetailsaboutmovieState extends State<Detailsaboutmovie> {
  int i = 0;
  List Similar_posters = [];
  @override
  Widget build(BuildContext context) {
    List aboutORsimilar = [
      Column(
        children: [
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      about_categories(
                          topic: "Language",
                          x: widget.language
                              .map((x) => x["english_name"])
                              .join(' , ')),
                      about_categories(
                          topic: "Duration", x: "${widget.duration}m"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      about_categories(
                      
                          topic: "Rate",
                          x: "${widget.rate.toStringAsFixed(1)}/10"),
                      about_categories(topic: "Genre", x: widget.genre),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    "Actors",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                  SizedBox(
                    height: 170,
                    child: BlocBuilder<Movies_Cubit, Movies_state>(
                        builder: (context, state) {
                    Similar_posters = BlocProvider.of<Movies_Cubit>(context).Similar_posters;
                      if (state is Loading) {
                        return const LoadingScreen();
                      } else if (state is Success) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15, top: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 110,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                (state.actors[i][1] == "https://image.tmdb.org/t/p/originalnull") ? "https://i.sstatic.net/0sMFl.png" : state.actors[i][1]),
                                            fit: BoxFit.fill)),
                                  ),
                                  Text("${state.actors[i][0]}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Text(state.actors[i][2],
                                      style: const TextStyle(color: Colors.white70)),
                                ],
                              ),
                            );
                          },
                          itemCount: state.actors.length,
                        );
                      } else {
                        return const Text("");
                      }
                    }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      Display_pictures(x: Similar_posters)
    ];

    return BlocBuilder<Movies_Cubit, Movies_state>(builder: (context, state) {
      if (state is Loading) {
        return const CircularProgressIndicator();
      } else {
        return Column(
          children: [
            NavigationView(
                onChangePage: (x) {
                  setState(() {
                    i = x;
                  });
                },
                borderTopColor: Colors.white12,
                backgroundColor: const Color.fromARGB(255, 10, 6, 46),
                items: [
                  ItemNavigationView(
                      childAfter: const Text(
                        "About",
                        style: TextStyle(color: Colors.red, fontFamily: "IBMP"),
                      ),
                      childBefore: const Text(
                        "About",
                        style: TextStyle(color: Colors.teal),
                      )),
                  ItemNavigationView(
                      childAfter: const Text(
                        "Similar",
                        style: TextStyle(color: Colors.red),
                      ),
                      childBefore: const Text(
                        "Similar",
                        style: TextStyle(color: Colors.teal),
                      )),
                ]),
            aboutORsimilar[i],
          ],
        );
      }
    });
  }
}
