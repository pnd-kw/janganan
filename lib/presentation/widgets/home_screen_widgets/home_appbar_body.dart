import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janganan/bloc/janganan/janganan_bloc.dart';
// import 'package:janganan/config/theme.dart';
import 'package:janganan/data/models/categories.dart';
import 'package:janganan/data/models/category_model.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/campaign_banner.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/campaign_slider.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/category_button.dart';
import 'package:janganan/presentation/widgets/home_screen_widgets/div_title.dart';

class HomeAppBarBody extends StatelessWidget {
  const HomeAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Category vegetableCat = categories[Categories.vegetable]!;
    final Category fruitCat = categories[Categories.fruit]!;
    final Category spicesCat = categories[Categories.spices]!;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).primaryColor,
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
                    // CategoryButton in home screen widgets directory
                    CategoryButton(
                      catImage: Image.asset(
                        'assets/images/ic-vegetables.png',
                      ),
                      catTitle: 'Vegetables',
                      onPressed: () {
                        context.read<JangananBloc>().add(
                            LoadByCategoryEvent(selectedCat: vegetableCat));
                        Navigator.of(context).pushNamed('/vegetables-screen');
                      },
                    ),
                    CategoryButton(
                      catImage: Image.asset(
                        'assets/images/ic-fruits.png',
                      ),
                      catTitle: 'Fruits',
                      onPressed: () {
                        context
                            .read<JangananBloc>()
                            .add(LoadByCategoryEvent(selectedCat: fruitCat));
                        Navigator.of(context).pushNamed('/fruits-screen');
                      },
                    ),
                    CategoryButton(
                      catImage: Image.asset(
                        'assets/images/ic-spices.png',
                      ),
                      catTitle: 'Spices',
                      onPressed: () {
                        context
                            .read<JangananBloc>()
                            .add(LoadByCategoryEvent(selectedCat: spicesCat));
                        Navigator.of(context).pushNamed('/spices-screen');
                      },
                    ),
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
