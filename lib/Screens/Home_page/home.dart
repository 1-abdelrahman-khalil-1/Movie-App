import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Screens/Home_page/Widgets/Displaypictures.dart';
import 'package:movie_app/Screens/Home_page/Widgets/Headerofdisplay.dart';
import 'package:movie_app/Screens/Home_page/Widgets/TopContainer.dart';
import 'package:movie_app/Screens/bottomnavigation.dart';
import 'package:movie_app/Data/data.dart';

class Home_screen extends StatefulWidget {
  Home_screen({super.key, required this.i});
  int i;
  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  List popular_movies = [],
      popular_posters = [],
      latest_movies = [],
      latest_posters = [],
      toprated = [],
      toprated_posters = [],
      upcoming_movies = [],
      upcoming_posters = [];
  Api service = Api();

  void initState() {
    // TODO: implement initState
    super.initState();
    get_popular();
    get_latest();
    get_top_rated();
    get_upcoming();
  }

  get_popular() async {
    popular_movies = await service.get_popular_data();
    for (int i = 0; i < popular_movies.length; i++) {
      popular_posters.add([
        "https://image.tmdb.org/t/p/original${popular_movies[i]["poster_path"]}",
        popular_movies[i]["id"]
      ]);
    }
    setState(() {});
  }

  get_latest() async {
    latest_movies = await service.get_latest_data();
    for (int i = 0; i < latest_movies.length; i++) {
      latest_posters.add([
        "https://image.tmdb.org/t/p/original${latest_movies[i]["poster_path"]}",
        latest_movies[i]["id"]
      ]);
    }
    setState(() {});
  }

  get_top_rated() async {
    toprated = await service.get_popular_data();
    for (int i = 0; i < toprated.length; i++) {
      toprated_posters.add([
        "https://image.tmdb.org/t/p/original${toprated[i]["poster_path"]}",
        toprated[i]["id"]
      ]);
    }
    setState(() {});
  }

  get_upcoming() async {
    upcoming_movies = await service.get_upcoming_data();
    for (int i = 0; i < upcoming_movies.length; i++) {
      upcoming_posters.add([
        "https://image.tmdb.org/t/p/original${upcoming_movies[i]["poster_path"]}",
        upcoming_movies[i]["id"]
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (toprated_posters.isEmpty ||
        popular_posters.isEmpty ||
        latest_posters.isEmpty ||
        upcoming_movies.isEmpty) {
      return const SafeArea(
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 10, 6, 46),
              body: SpinKitFadingFour(
                color: Colors.white,
                size: 60,
              )));
    } else {
      return SafeArea(
          child: Scaffold(
              bottomNavigationBar: Bottomnavigation(i: widget.i),
              backgroundColor: const Color.fromARGB(255, 10, 6, 46),
              body: ListView(children: [
                const Topcontainer(),
                const Headerofdisplay(first: "Most Popular", second: "See all"),
                Displaypictures(x: popular_posters),
                const Headerofdisplay(
                    first: "Latest Movies", second: "See all"),
                Displaypictures(x: latest_posters),
                const Headerofdisplay(
                    first: "Upcoming Movies", second: "See all"),
                Displaypictures(x: upcoming_posters)
              ])));
    }
  }
}
