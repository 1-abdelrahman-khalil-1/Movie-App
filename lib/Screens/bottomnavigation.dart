import 'package:flutter/material.dart';
import 'package:movie_app/Screens/Home_page/home.dart';
import 'package:movie_app/Screens/Saved%20Screen/Saved_Screen.dart';
import 'package:movie_app/Screens/Search_Page/search.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Bottomnavigation extends StatefulWidget {
  Bottomnavigation({super.key, required this.i });
    int i;
  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
        currentIndex: widget.i,
        onTap: (x) {
          setState(() {
            widget.i = x;
          if(widget.i == 0)
          {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_screen(i: widget.i)));
            }
            if (widget.i == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Search(i: widget.i)));
            } else if (widget.i == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SavedScreen(
                            i: widget.i,
                          )));
            } 
          
          });
        },
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              selectedColor: Colors.red,
              unselectedColor: Colors.white54),
          SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.red,
              unselectedColor: Colors.white54),
          SalomonBottomBarItem(
              icon: const Icon(Icons.bookmark),
              title: const Text("Saved"),
              selectedColor: Colors.red,
              unselectedColor: Colors.white54)
        ]);
  }
}
