import 'package:flutter/material.dart';

void showCustomBottomModel(context, content) {
  showModalBottomSheet(
    context: context,
    builder: (context) => content,
    barrierColor: Colors.black.withOpacity(.2),
  );
}
