import 'package:flutter/material.dart';
import 'package:movie_app/Screens/Screen2/screen2.dart';

class Display_pictures extends StatefulWidget {
  const Display_pictures({super.key, required this.x});
  final List x;

  @override
  State<Display_pictures> createState() => _Display_picturesState();
}

class _Display_picturesState extends State<Display_pictures> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemBuilder: (context, i) {
          return InkWell(
            borderRadius: BorderRadius.all(Radius.elliptical(15, 35)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowSelected(
                            id: widget.x[i][1],
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              width: 110,
              
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(15, 35)),
                  image: DecorationImage(image: NetworkImage(widget.x[i][0]) , fit: BoxFit.fill)),
            ),
          );
        },
        itemCount: widget.x.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
