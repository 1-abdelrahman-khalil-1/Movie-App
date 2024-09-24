import 'package:flutter/material.dart';
import 'package:movie_app/Data/data.dart';
import 'package:movie_app/Screens/bottomnavigation.dart';

class SearchResults extends StatefulWidget {
  SearchResults({super.key, required this.i, required this.get_movie});
  int i;
 final String get_movie;
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Api service = Api();
  List search_results = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  get_results() async {
    search_results = await service.get_searched_data(widget.get_movie);
    setState(() {
      
    });
  }
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 6, 46),
      bottomNavigationBar: Bottomnavigation(i: widget.i),
          body: ListView(
            children: [
              Container(
                width: double.infinity,

              )
            ],
          ),
    )
    );
  }
}
