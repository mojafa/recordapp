import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';

class TopCarousel extends StatefulWidget {
  const TopCarousel({Key key, this.isAbout = false}) : super(key: key);
  final bool isAbout;

  @override
  State<TopCarousel> createState() => _TopCarouselState();
}

class _TopCarouselState extends State<TopCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final urlImages = [
    'assets/images/add1.jpeg',
    'assets/images/add2.jpeg',
    'assets/images/add3.jpeg',
    'assets/images/add4.jpeg',
    'assets/images/add5.jpeg',
    'assets/images/add6.jpeg',
    'assets/images/add7.jpeg',
    'assets/images/add8.jpeg',
    'assets/images/add9.jpeg',
    'assets/images/add10.jpeg'
  ];
  final urlImagesAbout = [
    'assets/images/slider_one.png',
    'assets/images/slider_two.png',
    'assets/images/slider_three.png',
    'assets/images/slider_four.png',
    'assets/images/slider_five.png',
    'assets/images/slider_six.png',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            //height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: widget.isAbout ? 1 : 0.9,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) => setState(() => _current = index),
          ),
          itemCount: widget.isAbout ? urlImagesAbout.length : urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage =
                widget.isAbout ? urlImagesAbout[index] : urlImages[index];
            return Container(
              margin:
                  widget.isAbout ? EdgeInsets.symmetric(horizontal: 5.0) : null,
              child: BaseImage(
                imageUrl: urlImage,
                isAsset: true,
                height: size.height * 0.33,
                width: size.width,
                radius: 0,
                overlay: !widget.isAbout,
                overlayOpacity: 0.001,
                overlayStops: [0.3, 0.8],
              ),
            );
          },
        ),
        Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
            )),
      ],
    ));
  }
}
