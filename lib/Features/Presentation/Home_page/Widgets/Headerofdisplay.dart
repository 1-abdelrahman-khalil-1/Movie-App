import 'package:flutter/material.dart';

class Headerofdisplay extends StatelessWidget {
  const Headerofdisplay({super.key, required this.first, required this.second});
  final String first , second;
  @override
  Widget build(BuildContext context) {
    return Padding(
             padding: const EdgeInsets.all(14),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(first ,style: const TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20)),       
                 InkWell(
                  onTap:() =>{} ,
                  child: Text(second ,style: const TextStyle(color: Colors.white  , fontSize: 15)),
                 )
               ],
             ),
           );
  }
}