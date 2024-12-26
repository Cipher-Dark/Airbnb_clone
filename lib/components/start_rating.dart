import 'package:flutter/material.dart';

class StartRating extends StatefulWidget {
  final double rating;
  const StartRating({super.key, required this.rating});

  @override
  State<StartRating> createState() => _StartRatingState();
}

class _StartRatingState extends State<StartRating> {
  Widget star(bool fill) {
    return Icon(
      Icons.star,
      size: 18,
      color: fill ? Colors.black : Colors.black26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < (widget.rating).round()) {
          return star(true);
        } else {
          return star(false);
        }
      }),
    );
  }
}
