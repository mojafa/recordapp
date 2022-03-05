import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';

class TopCarousel extends StatefulWidget {
  @override
  State<TopCarousel> createState() => _TopCarouselState();
}

class _TopCarouselState extends State<TopCarousel> {
  int _current = 0;
  CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance.collection('adverts').snapshots(),
    //     builder: (ctx, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Container(
    //           color: Theme.of(context).shadowColor,
    //           child: AspectRatio(
    //             aspectRatio: 16 / 9,
    //           ),
    //         );
    //       }
    // return CarouselSlider(
    //   options: CarouselOptions(
    //     aspectRatio: 16 / 9,
    //     viewportFraction: 0.8,
    //     initialPage: 0,
    //     enableInfiniteScroll: true,
    //     reverse: false,
    //     autoPlay: true,
    //     autoPlayInterval: Duration(seconds: 8),
    //     autoPlayAnimationDuration: Duration(seconds: 2),
    //     autoPlayCurve: Curves.fastOutSlowIn,
    //     // enlargeCenterPage: true,
    //     scrollDirection: Axis.horizontal,
    //   ),
    //   items: [
    //     Image.network(
    //       'https://www.imf.org/external/pubs/ft/fandd/2020/06/images/frieden-1600.jpg',
    //       fit: BoxFit.cover,
    //     )
    //   ],
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          CarouselSlider(
            items: List.generate(
              10,
              (index) => BaseImage(
                imageUrl:
                    'https://www.imf.org/external/pubs/ft/fandd/2020/06/images/frieden-1600.jpg',
                height: size.height * 0.33,
                width: size.width,
                radius: 0,
                overlay: true,
                overlayOpacity: 0.1,
                overlayStops: [0.3, 0.8],
              ),
            ),
            carouselController: _controller,
            options: CarouselOptions(
                height: size.height * 0.26,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                // enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor,
                    ])),
                width: size.width,
                height: size.height * 0.20,
              )),
        ]),
        Container(
          width: size.width,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(10, (index) => null)
                  .asMap()
                  .entries
                  .map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: _current == entry.key ? 20.0 : 8.0,
                    height: 5.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (_current == entry.key
                                ? Colors.green
                                : Theme.of(context).primaryColor)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            )
          ]),
        )
      ],
    );
    // });
  }
}
