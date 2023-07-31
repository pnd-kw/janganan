import 'package:flutter/material.dart';
import 'package:janganan/utils/colors.dart';
import 'package:janganan/widgets/campaign_banner.dart';
import 'package:janganan/widgets/campaign_slider.dart';
import 'package:janganan/widgets/category_item.dart';
import 'package:janganan/widgets/div_title.dart';

class AppBarScroll extends StatelessWidget {
  const AppBarScroll({
    super.key,
    required this.title,
    this.actions,
  });

  final String title;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: AppColor.primaryColor,
          // expandedHeight: 150,
          pinned: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              // Reusable AppBar title
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // Reusable actions Widget
              child: actions,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/appbar-bg-img.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // CampaignBanner in Widget Directory
              CampaignBanner(
                title: 'Ayo makan sayuran dan rasakan manfaat kesehatannya',
                subtitle:
                    '“ Badan Kesehatan Dunia (WHO) secara umum menganjurkan'
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
              const CampaignSlider(),
            ],
          ),
        ),
        // const SliverFillRemaining(),
      ],
    );
  }
}
