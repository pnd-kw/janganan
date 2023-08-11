import 'package:flutter/material.dart';

class CenterCursorTextEditingController extends TextEditingController {
  CenterCursorTextEditingController({String? text}) : super(text: text);

  @override
  set value(TextEditingValue newValue) {
    final newSelection =
        TextSelection.collapsed(offset: newValue.text.length ~/ 2);
    super.value = newValue.copyWith(selection: newSelection);
  }
}
