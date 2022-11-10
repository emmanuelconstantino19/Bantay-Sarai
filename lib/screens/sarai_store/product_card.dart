import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.image,
    this.title,
    this.price,
    this.press,
    this.bgColor,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final int price;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Material(
        child: Container(
        width: 154,
        // padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
          border: Border.all(color: Colors.grey[300])
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(
                    Radius.circular(defaultBorderRadius)),
              ),
              child: Image.network(
                image,
                height: 132,
              ),
            ),
            // const SizedBox(height: defaultPadding / 2),
            Container(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  price.toString() + " SRB",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}