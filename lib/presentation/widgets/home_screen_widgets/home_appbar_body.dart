import 'package:flutter/material.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/campaign_banner.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/campaign_slider.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/category_item.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/div_title.dart';

class HomeAppBarBody extends StatelessWidget {
  const HomeAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          pinned: true,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Hello!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: Image.asset('assets/images/ic-cart.png'),
                label: Text(
                  'Cart',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(3),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  shadowColor: MaterialStatePropertyAll(Colors.grey),
                ),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // CampaignBanner in home screen widgets directory
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
                    // CategoryItem in home screen widgets directory
                    CategoryItem(
                        catImage: Image.asset(
                          'assets/images/ic-vegetables.png',
                        ),
                        catTitle: 'Vegetables',
                        onPressed: () => Navigator.of(context)
                            .pushNamed('/vegetables-screen')),
                    CategoryItem(
                        catImage: Image.asset(
                          'assets/images/ic-fruits.png',
                        ),
                        catTitle: 'Fruits',
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/fruits-screen')),
                    CategoryItem(
                        catImage: Image.asset(
                          'assets/images/ic-spices.png',
                        ),
                        catTitle: 'Spices',
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/spices-screen')),
                  ],
                ),
              ),
              const DivTitle(title: 'CAMPAIGN'),
              // Campaign Slider in home screen widgets directory
              const CampaignSlider(),
            ],
          ),
        ),
      ],
    );
  }
}
