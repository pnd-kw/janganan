import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janganan/bloc/card/bloc/card_bloc.dart';
import 'package:janganan/data/models/janganan_item_model.dart';
import 'package:janganan/utils/constants/colors.dart';

class JangananListItems extends StatelessWidget {
  const JangananListItems({
    super.key,
    required this.index,
    required this.isExpanded,
    required this.filteredItems,
  });

  final int index;
  final bool isExpanded;
  final List<JangananItem> filteredItems;

  @override
  Widget build(BuildContext context) {
    // final jangananState = context.watch<JangananBloc>().state;

    return GestureDetector(
      onTap: () {
        context.read<CardBloc>().add(ToggleCard(cardIndex: index));
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: isExpanded ? 200 : 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        filteredItems[index].itemImg,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredItems[index].itemName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              filteredItems[index].category.title,
                              style: GoogleFonts.mPlus1p(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: filteredItems[index].category.catIcon,
                            )
                          ],
                        ),
                        Text(
                          'stok: ${filteredItems[index].stock.toString()}',
                          style: GoogleFonts.mPlus1p(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'harga: ${filteredItems[index].price.toString()}',
                          style: GoogleFonts.mPlus1p(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: AppColor.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              child: Text(
                                'Add to Cart',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '*harga dapat berubah sewaktu-waktu, jika ada perbedaan harga, maka harga di tempat adalah harga yang berlaku',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
