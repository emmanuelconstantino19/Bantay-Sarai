import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'product_card.dart';
import 'section_title.dart';
import 'package:bantay_sarai/models/Product.dart';

class NewArrivalProducts extends StatefulWidget {
  const NewArrivalProducts({ Key key }) : super(key: key);

  @override
  _NewArrivalProductsState createState() => _NewArrivalProductsState();
}

class _NewArrivalProductsState extends State<NewArrivalProducts> {
  List<Product> demo_product = [
    Product(
      image: "assets/images/product_0.png",
      title: "Long Sleeve Shirts",
      price: 165,
      bgColor: const Color(0xFFFEFBF9),
    ),
    Product(
      image: "assets/images/product_1.png",
      title: "Casual Henley Shirts",
      price: 99,
    ),
    Product(
      image: "assets/images/product_2.png",
      title: "Curved Hem Shirts",
      price: 180,
      bgColor: const Color(0xFFF8FEFB),
    ),
    Product(
      image: "assets/images/product_3.png",
      title: "Casual Nolin",
      price: 149,
      bgColor: const Color(0xFFEEEEED),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "New Arrival",
            pressSeeAll: () {},
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              demo_product.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: demo_product[index].title,
                  image: demo_product[index].image,
                  price: demo_product[index].price,
                  bgColor: demo_product[index].bgColor,
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           DetailsScreen(product: demo_product[index]),
                    //     ));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}