import 'package:flutter/material.dart';

class Headerofdisplay extends StatelessWidget {
  const Headerofdisplay({super.key, required this.first, required this.second});
  final String first , second;
  @override
  Widget build(BuildContext context) {
    return Padding(
             padding: EdgeInsets.all(14),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(first ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20)),       
                 InkWell(
                  onTap:() =>{} ,
                  child: Text(second ,style: TextStyle(color: Colors.white  , fontSize: 15)),
                 )
               ],
             ),
           );
  }
}