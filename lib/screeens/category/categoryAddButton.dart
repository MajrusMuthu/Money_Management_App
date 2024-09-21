// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryPopupButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const CategoryPopupButton({
    Key? key,
    this.onTap,
    required this.text,
    Future<Null> Function()? onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(horizontal: 80.0),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
