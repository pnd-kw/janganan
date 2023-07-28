import 'package:flutter/material.dart';
import 'package:janganan/utils/colors.dart';
import 'package:janganan/widgets/campaign_banner.dart';
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
              CampaignBanner(
                title: 'Ayo makan sayuran dan rasakan manfaat kesehatannya',
                subtitle:
                    '“ Badan Kesehatan Dunia (WHO) secara umum menganjurkan'
                    'konsumsi sayuran dan buah-buahan untuk hidup sehat sejumlah'
                    ' 400 gram per orang per hari ...”',
                image: Image.asset('assets/images/vegetables-img.png'),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 300,
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Card(
              //         surfaceTintColor: Colors.transparent,
              //         elevation: 10,
              //         child: Padding(
              //           padding: const EdgeInsets.all(10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.end,
              //                 children: [
              //                   SizedBox(
              //                     width: 150,
              //                     child: Text(
              //                       'Ayo makan sayuran dan rasakan manfaat kesehatannya',
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .titleMedium!
              //                           .copyWith(
              //                             color: Theme.of(context)
              //                                 .colorScheme
              //                                 .onBackground,
              //                           ),
              //                     ),
              //                   ),
              //                   Image.asset('assets/images/vegetables-img.png'),
              //                 ],
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(
              //                     vertical: 10, horizontal: 40),
              //                 child: Text(
              //                   '“ Badan Kesehatan Dunia (WHO) secara umum menganjurkan'
              //                   'konsumsi sayuran dan buah-buahan untuk hidup sehat sejumlah'
              //                   ' 400 gram per orang per hari ...”',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodySmall!
              //                       .copyWith(
              //                         color: Theme.of(context)
              //                             .colorScheme
              //                             .onBackground,
              //                       ),
              //                   textAlign: TextAlign.justify,
              //                 ),
              //               ),
              //               ElevatedButton(
              //                 onPressed: () {},
              //                 style: ElevatedButton.styleFrom(
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                   ),
              //                   backgroundColor: AppColor.secondaryColor,
              //                 ),
              //                 child: Text(
              //                   'CARI SAYURAN, BUAH, ATAU BUMBU',
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .titleSmall!
              //                       .copyWith(
              //                         color: Theme.of(context)
              //                             .colorScheme
              //                             .background,
              //                       ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 20,
              //   ),
              //   child: Text(
              //     'KATEGORI',
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleSmall!
              //         .copyWith(color: Colors.grey),
              //   ),
              // ),
              const DivTitle(title: 'KATEGORI'),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                    //       Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 50,
                    //             child: IconButton.filled(
                    //               onPressed: () {},
                    //               style: Theme.of(context).iconButtonTheme.style,
                    //               // style: IconButton.styleFrom(
                    //               //   shape: RoundedRectangleBorder(
                    //               //     borderRadius: BorderRadius.circular(10),
                    //               //   ),
                    //               //   backgroundColor: Colors.white,
                    //               //   elevation: 2,
                    //               //   shadowColor: Colors.grey,
                    //               // ),
                    //               icon: Image.asset(
                    //                 'assets/images/ic-vegetables.png',
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(5),
                    //             child: Text(
                    //               'Vegetables',
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodySmall!
                    //                   .copyWith(
                    //                       color: Theme.of(context)
                    //                           .colorScheme
                    //                           .onBackground),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 50,
                    //             child: IconButton.filled(
                    //               onPressed: () {},
                    //               style: Theme.of(context).iconButtonTheme.style,
                    //               // style: IconButton.styleFrom(
                    //               //   shape: RoundedRectangleBorder(
                    //               //     borderRadius: BorderRadius.circular(10),
                    //               //   ),
                    //               //   backgroundColor: Colors.white,
                    //               //   elevation: 2,
                    //               //   shadowColor: Colors.grey,
                    //               // ),
                    //               icon: Image.asset('assets/images/ic-fruits.png'),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(5),
                    //             child: Text(
                    //               'Fruits',
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodySmall!
                    //                   .copyWith(
                    //                       color: Theme.of(context)
                    //                           .colorScheme
                    //                           .onBackground),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 50,
                    //             child: IconButton.filled(
                    //               onPressed: () {},
                    //               style: Theme.of(context).iconButtonTheme.style,
                    //               // style: IconButton.styleFrom(
                    //               //   shape: RoundedRectangleBorder(
                    //               //     borderRadius: BorderRadius.circular(10),
                    //               //   ),
                    //               //   backgroundColor: Colors.white,
                    //               //   elevation: 2,
                    //               //   shadowColor: Colors.grey,
                    //               // ),
                    //               icon: Image.asset('assets/images/ic-spices.png'),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(5),
                    //             child: Text(
                    //               'Spices',
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .bodySmall!
                    //                   .copyWith(
                    //                       color: Theme.of(context)
                    //                           .colorScheme
                    //                           .onBackground),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                  ],
                ),
              ),
              const DivTitle(title: 'CAMPAIGN'),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Text(
              //     'CAMPAIGN',
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleSmall!
              //         .copyWith(color: Colors.grey),
              //   ),
              // )
            ],
          ),
        ),
        SliverFillRemaining(),
      ],
    );
  }
}
