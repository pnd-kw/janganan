import 'package:flutter/material.dart';

class ReusableProgressDialog extends StatelessWidget {
  const ReusableProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.background),
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
