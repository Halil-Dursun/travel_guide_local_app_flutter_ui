import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_mobile_app/utils/consts/images.dart';

class SliderImages extends StatelessWidget {
  const SliderImages({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: true,
      ),
      items: ImagesList().imagePathList
          .map(
            (e) => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(e),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}