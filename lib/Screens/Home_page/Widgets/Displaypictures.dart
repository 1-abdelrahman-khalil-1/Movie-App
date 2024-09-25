import 'package:flutter/material.dart';
import 'package:movie_app/Screens/Screen2/screen2.dart';

class Displaypictures extends StatefulWidget {
  const Displaypictures({super.key, required this.x});
  final List x;

  @override
  State<Displaypictures> createState() => _DisplaypicturesState();
}

class _DisplaypicturesState extends State<Displaypictures> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 190,
             child: ListView.builder(itemBuilder: (context , i){
              return InkWell(
                borderRadius: const BorderRadius.all(Radius.elliptical(15 , 35)) ,
                onTap: () {
                  
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowSelected( id: widget.x[i][1],)) );
                  
                },
                child: Container(    
                 width: 135,
                 decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.elliptical(15 , 35)) ,
                   image: DecorationImage(image: NetworkImage( widget.x[i][0]))
                 ),
                ),
              );
             } , itemCount: widget.x.length ,scrollDirection: Axis.horizontal,),
           );
  }
}