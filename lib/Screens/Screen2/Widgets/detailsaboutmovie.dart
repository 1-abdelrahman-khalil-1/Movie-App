import 'package:flutter/material.dart';
import 'package:movie_app/Data/data.dart';
import 'package:movie_app/Screens/Saved%20Screen/Widgets/Display_pictures.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';

class about_categories extends StatelessWidget {
  const about_categories(
      {super.key, required this.topic, required this.x, this.genre});

  final x, topic, genre;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topic,
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
        Text(
          "$x",
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

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
  List actors = [], Similar_posters = [], sim = [];
  Api service = Api();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_actors();
    get_similar();
  }

  get_actors() async {
    List p = await service.get_actors_data(widget.id);
    for (int i = 0; i < p.length; i++) {
      actors.add([
        p[i]["name"],
        "https://image.tmdb.org/t/p/original${p[i]["profile_path"]}",
        p[i]["character"]
      ]);
    }
    setState(() {});
  }

  get_similar() async {
    sim = await service.get_similar(widget.id);
    for (int i = 0; i < sim.length; i++) {
      Similar_posters.add([
        "https://image.tmdb.org/t/p/original${sim[i]["poster_path"]}",
        sim[i]["id"]
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List m = [
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
                      about_categories(topic: "Genre", x: "${widget.genre}"),
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
              Text(
                "Actors",
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              SizedBox(
                height: 170,
                child: ListView.builder(
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
                                    image: NetworkImage("${actors[i][1]}"),
                                    fit: BoxFit.fill)),
                          ),
                          Text("${actors[i][0]}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          Text(actors[i][2],
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    );
                  },
                  itemCount: actors.length,
                ),
              )
                              ],
                            ),
            ),
          )
        ],
      ),

      Display_pictures(x: Similar_posters)
    ];

    return Column(
      children: [
        NavigationView(
            onChangePage: (x) {
              setState(() {
                i = x;
              });
            },
            borderTopColor: Colors.white12,
            backgroundColor: Color.fromARGB(255, 10, 6, 46),
            items: [
              ItemNavigationView(
                  childAfter: Text(
                    "About",
                    style: TextStyle(color: Colors.red, fontFamily: "IBMP"),
                  ),
                  childBefore: Text(
                    "About",
                    style: TextStyle(color: Colors.teal),
                  )),
              ItemNavigationView(
                  childAfter: Text(
                    "Similar",
                    style: TextStyle(color: Colors.red),
                  ),
                  childBefore: Text(
                    "Similar",
                    style: TextStyle(color: Colors.teal),
                  )),
            ]),
        m[i],
      ],
    );
  }
}
