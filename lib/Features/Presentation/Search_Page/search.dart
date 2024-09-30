import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/utilities/pushNavigator.dart';
import 'package:movie_app/Core/utilities/bottomnavigation.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Search_Page/search_results.dart';

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
              style: const TextStyle(color: Colors.white),
              controller: value,
              onSubmitted: (value) {
                setState(() {
                  movie = value;
                });
                BlocProvider.of<Movies_Cubit>(context).get_results(movie);
                PushNavigator.navigateTo(context, SearchResults(
                      i: 1,
                    ));
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  size: 35,
                  color: Colors.white38,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(style: BorderStyle.none, width: 0)),
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
