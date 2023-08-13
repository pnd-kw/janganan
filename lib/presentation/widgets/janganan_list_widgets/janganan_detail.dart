import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JangananDetail extends StatelessWidget {
  const JangananDetail({
    super.key,
    required this.itemName,
    required this.itemCategory,
    required this.catImage,
    required this.itemStock,
    required this.itemPrice,
  });

  final String itemName;
  final dynamic itemCategory;
  final Image catImage;
  final String itemStock;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              itemCategory,
              style: GoogleFonts.mPlus1p(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 20,
              child: catImage,
            )
          ],
        ),
        Text(
          itemStock,
          style: GoogleFonts.mPlus1p(
            fontSize: 12,
          ),
        ),
        Text(
          itemPrice,
          style: GoogleFonts.mPlus1p(fontSize: 12),
        ),
      ],
    );
  }
}
