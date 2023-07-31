import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/promo-banner-img-1.png',
  'assets/images/promo-banner-img-2.png',
  'assets/images/promo-banner-img-3.png'
];

class CampaignSlider extends StatelessWidget {
  const CampaignSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
          autoPlay: true,
          height: 145,
        ),
      ),
    );
  }
}

final List<Widget> imageSliders = imgList
    .map(
      (item) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 0,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Image.asset(
            item,
            fit: BoxFit.cover,
          ),
        ),
      ),
    )
    .toList();
