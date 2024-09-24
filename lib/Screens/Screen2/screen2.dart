import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Data/data.dart';
import 'package:movie_app/Screens/Screen2/Widgets/detailsaboutmovie.dart';
import 'package:movie_app/Screens/bottomnavigation.dart';
import 'package:movie_app/main.dart';

class ShowSelected extends StatefulWidget {
  const ShowSelected({super.key, required this.id});
  final int id;
  @override
  State<ShowSelected> createState() => _ShowSelectedState();
}

class _ShowSelectedState extends State<ShowSelected> {
  int i = 0, duration = 0;
  String path = "", name = "", overview = "", release_date = "";
  double rate = 0;
  Api service = Api();
  List same_posters = [], language = [];
  String genre = "";
  Map<String, dynamic> Details = {};
  bool selected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_movie();
  }

  get_movie() async {
    Details = await service.get_movie_data(widget.id);
    path = "https://image.tmdb.org/t/p/original${Details["poster_path"]}";
    name = Details["title"];
    overview = Details["overview"];
    duration = Details["runtime"];
    language = Details["spoken_languages"];
    rate = Details["vote_average"];
    genre = Details["genres"].map((x) => x["name"]).join(" , ");

    for (int i = 0; i < 4; i++) {
      release_date += Details["release_date"][i];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (Details.length == 0)
      return const SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 10, 6, 46),
            body: SpinKitFadingFour(
              color: Colors.white,
              size: 60,
            )),
      );
    else {
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Bottomnavigation(i: 0),
          backgroundColor: const Color.fromARGB(255, 10, 6, 46),
          body: ListView(
            children: [
              SizedBox(
                height: 450,
                child: Stack(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 420,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(path), fit: BoxFit.fill))),
                    Container(
                      margin: const EdgeInsets.only(top: 318),
                      decoration: const BoxDecoration(boxShadow: [
                        const BoxShadow(
                          blurStyle: BlurStyle.normal,
                          blurRadius: 70,
                          color: Color.fromARGB(236, 0, 0, 0),
                        )
                      ]),
                      height: 80,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  fontFamily: "IBMP",
                                  fontSize: 30,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 60,
                              width: 250,
                              child: Text(
                                "$release_date • $genre",
                                style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(94, 63, 81, 181),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                ))),
                        IconButton(
                            onPressed: () {
                              if (selected) {
                                setState(() {
                                  saved.removeWhere((e) => e[2] == saved[i][2]);
                                  selected = false;
                                });
                              } else {
                                setState(() {
                                  bool notfound = true;
                                  for (int i = 0; i < saved.length; i++) {
                                    if (saved[i][2] == path) notfound = false;
                                  }
                                  if (notfound) {
                                    saved.add([name, genre, path]);
                                    selected = true;
                                  }
                                });
                              }
                            },
                            icon: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(94, 63, 81, 181),
                                child: selected
                                    ? Icon(
                                        Icons.bookmark_add,
                                        color: Colors.deepOrange,
                                        size: 27,
                                      )
                                    : Icon(
                                        Icons.bookmark_add_outlined,
                                        color: Colors.white,
                                        size: 27,
                                      ))),
                      ],
                    )
                  ],
                ),
              ),
              Text(
                "$overview \n",
                style: const TextStyle(
                    fontFamily: "IBMP2", color: Colors.white60, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Detailsaboutmovie(
                id: widget.id,
                language: language,
                duration: duration,
                rate: rate,
                genre: genre,
              ),
            ],
          ),
        ),
      );
    }
  }
}

/*
GridView.count(
          crossAxisCount: 3,
          children: List.generate(same_posters.length ,(x)
             {
                return Container(       
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.elliptical(20 , 25)) ,
                    image: DecorationImage(image: NetworkImage(same_posters[x][0] ), fit: BoxFit.fill )
                 ),
                ); 
             }),
        )
*/
