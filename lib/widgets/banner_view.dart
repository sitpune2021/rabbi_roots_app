import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerView extends StatelessWidget {
  final bool isFeatured;

  const BannerView({super.key, required this.isFeatured});

  @override
  Widget build(BuildContext context) {
    // Simple mock data for banner images
    List<String?> bannerList = [
      "assets/banner1.png", // Replace with your actual image assets
      "assets/banner2.png",
      "assets/banner3.png",
    ];

    // Create an Rx variable to track the current index
    Rx<int> currentIndex = Rx<int>(0);

    return bannerList.isEmpty
        ? const SizedBox()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.45,
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      viewportFraction: 0.95,
                      autoPlayInterval: const Duration(seconds: 7),
                      onPageChanged: (index, reason) {
                        // Update currentIndex when the carousel changes
                        currentIndex.value = index;
                      },
                    ),
                    itemCount: bannerList.length,
                    itemBuilder: (context, index, _) {
                      return InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              bannerList[index]!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(bannerList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Obx(() {
                        return index == currentIndex.value
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 1),
                                child: Text(
                                  '${index + 1}/${bannerList.length}',
                                  style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12),
                                ),
                              )
                            : Container(
                                height: 5,
                                width: 6,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                      }),
                    );
                  }),
                ),
              ],
            ),
          );
  }
}
