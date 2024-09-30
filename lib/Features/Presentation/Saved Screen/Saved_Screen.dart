import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/utilities/bottomnavigation.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Screen2/screen2.dart';

import 'package:movie_app/main.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({super.key, required this.i});
  int i;
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    if (saved.isEmpty) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 6, 46),
        bottomNavigationBar: Bottomnavigation(i: widget.i),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromARGB(94, 63, 81, 181),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ))),
            ),
            const Expanded(
              child: Center(
                  child: Text("Empty",
                      style: TextStyle(color: Colors.white24, fontSize: 50))),
            ),
          ],
        ),
      ));
    } else {
      return SafeArea(
          child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 6, 46),
        bottomNavigationBar: Bottomnavigation(i: widget.i),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: IconButton(
                  alignment: Alignment.topLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromARGB(94, 63, 81, 181),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ))),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, x) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<Movies_Cubit>(context)
                          .get_movie(saved[x][3]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowSelected(id: saved[x][3])));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 130,
                            width: 100,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(saved.elementAt(x)[2]))),
                          ),
                          SizedBox(
                            width: 150,
                            height: 170,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    saved[x][0],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    saved[x][1],
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 13),
                                  ),
                                  InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {},
                                      child: Container(
                                        height: 30,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            color: Colors.red[700],
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Center(
                                            child: Text("Watch Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w300))),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  saved.removeWhere((e) => e[2] == saved[x][2]);
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red[900]))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: saved.length,
              ),
            ),
          ],
        ),
      ));
    }
  }
}
