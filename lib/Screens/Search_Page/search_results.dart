import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/Data/cubit.dart';
import 'package:movie_app/Screens/Screen2/screen2.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<Movies_Cubit>(context).get_results(widget.get_movie);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Movies_Cubit, Movies_state>(builder: (context, state) {
      if (state is Loading) {
        return const SafeArea(
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 10, 6, 46),
              body: SpinKitFadingFour(
                color: Colors.white,
                size: 60,
              )),
        );
      } else if (state is Success) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 10, 6, 46),
          bottomNavigationBar: Bottomnavigation(i: widget.i),
          body: GridView.builder(
            
            itemBuilder: (context, x) {
              
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context , MaterialPageRoute(builder: (context)=> ShowSelected(id: state.search_results[x][3]))),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                       height: 250,
                      decoration: BoxDecoration(
                           
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage(
                            state.search_results[x][2],
                            
                          ),fit: BoxFit.fill, )
                          ),
                          child: Align(alignment: Alignment.topRight,child: Text("${state.search_results[x][1].toStringAsFixed(1)}" ,style: const TextStyle(fontSize: 17,color: Colors.black,backgroundColor: Colors.amber ,fontWeight: FontWeight.bold))),
                    ),
                  ),
                 Text(state.search_results[x][0] , style: const TextStyle(  color: Colors.white ,fontWeight: FontWeight.w900),),
              
                ],
              );
            },
            itemCount: state.search_results.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , mainAxisExtent: 350),
            
          ),
        ));
      } else if (state is Error) {
        return Text(state.Error_Message);
      } else
        return const Text("");
    });
  }
}
