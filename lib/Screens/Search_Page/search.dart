import 'package:flutter/material.dart';
import 'package:movie_app/Screens/Search_Page/search_results.dart';
import 'package:movie_app/Screens/bottomnavigation.dart';

class Search extends StatefulWidget {
  Search({super.key, required this.i});
  int i;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController value = TextEditingController();
  String movie = "";
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 10, 6, 46),
        bottomNavigationBar: Bottomnavigation(i: widget.i),
        body: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: value,
              onSubmitted: (value) {
                setState(() {
                  movie = value;
                });
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResults(
                              i: 1,
                              get_movie: movie,
                            )));
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search_outlined,
                  size: 35,
                  color: Colors.white38,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
