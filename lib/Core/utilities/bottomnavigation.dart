import 'package:flutter/material.dart';
import 'package:movie_app/Core/utilities/pushNavigator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../Features/Presentation/Home_page/home.dart';
import '../../Features/Presentation/Saved Screen/Saved_Screen.dart';
import '../../Features/Presentation/Search_Page/search.dart';

class Bottomnavigation extends StatefulWidget {
  Bottomnavigation({super.key, required this.i});
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
            if (widget.i == 0) {
              PushNavigator.navigateTo(context, Home_screen(i: widget.i));
            }
            if (widget.i == 1) {
              PushNavigator.navigateTo(context, Search(i: widget.i));
            } else if (widget.i == 2) {
              PushNavigator.navigateTo(context, SavedScreen(i: widget.i));
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
              unselectedColor: Colors.white54),
        ]);
  }
}
