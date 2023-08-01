import 'package:flutter/material.dart';
import 'package:janganan/widgets/appbar_scroll.dart';
import 'package:janganan/widgets/home_screen_widgets/campaign_banner.dart';
import 'package:janganan/widgets/home_screen_widgets/campaign_slider.dart';
import 'package:janganan/widgets/home_screen_widgets/category_item.dart';
import 'package:janganan/widgets/home_screen_widgets/div_title.dart';

class HomeAppBarBody extends StatelessWidget {
  const HomeAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarScroll(
      title: 'Hello!',
      //Cart Button
      actions: TextButton.icon(
        onPressed: () {},
        icon: Image.asset('assets/images/ic-cart.png'),
        label: Text(
          'Cart',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(3),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          shadowColor: MaterialStatePropertyAll(
            Colors.black.withOpacity(0.8),
          ),
        ),
      ),
      sliverChildListDelegate: SliverChildListDelegate(
        [
          // CampaignBanner in Widget Directory
          CampaignBanner(
            title: 'Ayo makan sayuran dan rasakan manfaat kesehatannya',
            subtitle: '“ Badan Kesehatan Dunia (WHO) secara umum menganjurkan'
                'konsumsi sayuran dan buah-buahan untuk hidup sehat sejumlah'
                ' 400 gram per orang per hari ...”',
            image: Image.asset('assets/images/vegetables-img.png'),
          ),
          // DivTitle in Widget Directory
          const DivTitle(title: 'KATEGORI'),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // CategoryItem in Widget Directory
                CategoryItem(
                  catImage: Image.asset(
                    'assets/images/ic-vegetables.png',
                  ),
                  catTitle: 'Vegetables',
                ),
                CategoryItem(
                  catImage: Image.asset(
                    'assets/images/ic-fruits.png',
                  ),
                  catTitle: 'Fruits',
                ),
                CategoryItem(
                  catImage: Image.asset(
                    'assets/images/ic-spices.png',
                  ),
                  catTitle: 'Spices',
                ),
              ],
            ),
          ),
          const DivTitle(title: 'CAMPAIGN'),
          // Campaign Slider in Widget Directory
          const CampaignSlider(),
        ],
      ),
    );
  }
}
