import 'package:flutter/material.dart';
import 'package:janganan/utils/constants/colors.dart';

class JangananAddToCart extends StatelessWidget {
  const JangananAddToCart({
    super.key,
    required this.addToCart,
    required this.buttonText,
  });

  final void Function()? addToCart;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: addToCart,
      style: TextButton.styleFrom(
          backgroundColor: AppColor.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.background,
            ),
      ),
    );
  }
}
