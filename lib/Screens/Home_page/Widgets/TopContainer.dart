import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:movie_app/Data/data.dart';

class Topcontainer extends StatefulWidget {
  const Topcontainer({super.key});

  @override
  State<Topcontainer> createState() => _TopcontainerState();
}

class _TopcontainerState extends State<Topcontainer> {   
    
    @override
    int i=0;
    Api service = Api();
    
    List toprated = [];
    List<Widget> toprated_posters = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    get_top_rated();
  }
  get_top_rated()async {
   toprated = await service.get_top_rated(); 
   for(int i = 0; i <10; i++) {
    toprated_posters.add(Container(decoration: BoxDecoration(  image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original${toprated[i]["poster_path"]}") ,fit: BoxFit.fill))));
   }
   setState(() {
   });
  }
    @override
  Widget build(BuildContext context) {
    return Stack(
              children: [
                CarouselSlider(
                   items: toprated_posters ,
                    options: CarouselOptions(
                        onPageChanged: (x, reason) {
                          setState((){
                            i = x;
                          });
                        },
                        autoPlay: true,
                        height: 350,
                        viewportFraction: 1,           
                        autoPlayAnimationDuration: const Duration(milliseconds: 1100),
                        autoPlayInterval: const Duration(seconds: 5))
                    ),
                Container(
                  margin: const EdgeInsets.only(top: 300),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 100, top: 315 ),
                 
                  child: DotsIndicator(
                  dotsCount: toprated_posters.length == 0 ? 1 : toprated_posters.length,
                  position: i,
                  decorator: DotsDecorator(
                      activeColor: Colors.red,
                      activeSize: const Size(18, 8),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                )
              ],
            );
  }
}