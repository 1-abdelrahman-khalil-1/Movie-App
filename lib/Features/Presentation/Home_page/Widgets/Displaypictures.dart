import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/utilities/pushNavigator.dart';
import 'package:movie_app/Features/Data/cubit.dart';
import 'package:movie_app/Features/Presentation/Screen2/screen2.dart';

class Displaypictures extends StatelessWidget {
  const Displaypictures({super.key, required this.x});
  final List x;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 190,
             child: ListView.builder(itemBuilder: (context , i){
              return InkWell(
                borderRadius: const BorderRadius.all(Radius.elliptical(15 , 35)) ,
                onTap: ()
            {
              BlocProvider.of<Movies_Cubit>(context).get_similar(x[i][1]);
              BlocProvider.of<Movies_Cubit>(context).get_actors(x[i][1]);
              BlocProvider.of<Movies_Cubit>(context).get_movie(x[i][1]);
              PushNavigator.navigateTo(context, ShowSelected(id: x[i][1]));        
            },
                child: Container(
                 width: 135 ,
                 decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.elliptical(15 , 35)) ,
                   image: DecorationImage(image: NetworkImage(x[i][0]))
                 ),
                ),
              );
             } , itemCount: x.length ,scrollDirection: Axis.horizontal,),
           );
  }
}