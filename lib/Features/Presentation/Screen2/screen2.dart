import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Core/utilities/bottomnavigation.dart';
import 'package:movie_app/Core/utilities/loading.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Screen2/Widgets/detailsaboutmovie.dart';
import 'package:movie_app/main.dart';

class ShowSelected extends StatefulWidget {
  const ShowSelected({super.key, required this.id});
  final int id;
  @override
  State<ShowSelected> createState() => _ShowSelectedState();
}

class _ShowSelectedState extends State<ShowSelected> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Movies_Cubit, Movies_state>(builder: (context, state) {
     
      if (state is Loading) {
        return const LoadingScreen();
      } else if (state is Success) {
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
                                  image: NetworkImage(state.path),
                                  fit: BoxFit.fill))),
                      Container(
                        margin: const EdgeInsets.only(top: 318),
                        decoration: const BoxDecoration(boxShadow: [
                           BoxShadow(
                            blurStyle: BlurStyle.normal,
                            blurRadius: 70,
                            color: Color.fromARGB(236, 0, 0, 0),
                          )
                        ]
                        ),
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
                                state.name,
                                style: const TextStyle(
                                    fontFamily: "IBMP",
                                    fontSize: 30,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            SizedBox(
                                height: 60,
                                width: 250,
                                child: Text(
                                  "${state.release_date} • ${state.genre}",
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
                                if (state.selected[widget.id] == true) {
                                  setState(() {
                                    saved.removeWhere(
                                        (e) => e[2] == state.path);
                                    state.selected[widget.id] = false;
                                  });
                                } else {
                                  setState(() {
                                    bool notfound = true;
                                    for (int i = 0; i < saved.length; i++) {
                                      if (saved[i][2] == state.path) {
                                        notfound = false;
                                      }
                                    }
                                    if (notfound) {
                                      saved.add([
                                        state.name,
                                        state.genre,
                                        state.path,
                                        widget.id
                                      ]);
                                      state.selected[widget.id] = true;
                                    }
                                  });
                                }
                              },
                              icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(94, 63, 81, 181),
                                  child: state.selected[widget.id] == true
                                      ? const Icon(
                                          Icons.bookmark_add,
                                          color: Colors.deepOrange,
                                          size: 27,
                                        )
                                      : const Icon(
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
                  "${state.overview} \n",
                  style: const TextStyle(
                      fontFamily: "IBMP2", color: Colors.white60, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Detailsaboutmovie(
                  id: widget.id,
                  language: state.language,
                  duration: state.duration,
                  rate: state.rate,
                  genre: state.genre,
                ),
              ],
            ),
          ),
        );
      } else if (state is Error) {
        return Text(state.Error_Message as String,
            style: const TextStyle(fontSize: 50));
      } else {
        return const Text("a");
      }
    });
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
