import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  final List<String> imageUrls = [
    'https://via.placeholder.com/600x300?text=Image+1',
    'https://via.placeholder.com/600x300?text=Image+2',
    'https://via.placeholder.com/600x300?text=Image+3',
    'https://via.placeholder.com/600x300?text=Image+4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Carousel Slider for Images
          CarouselSlider(
            items: imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 150.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          // Dot Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imageUrls.length,
              (index) => Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
