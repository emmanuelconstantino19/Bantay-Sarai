import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:bantay_sarai/models/Product.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  final customFunction;

  const DetailsScreen({ Key key, @required this.product, @required this.customFunction}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int itemCount;

  void initState() {
    itemCount = (widget.product.toBuy==0) ? 1 : widget.product.toBuy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     child: SvgPicture.asset(
          //       "assets/icons/Heart.svg",
          //       height: 20,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Column(
        children: [
          Image.network(
            widget.product.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        widget.product.price.toString() + " SRB / KG",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(
                      widget.product.description,
                    ),
                  ),
                  // Text(
                  //   "Colors",
                  //   style: Theme.of(context).textTheme.subtitle2,
                  // ),
                  const SizedBox(height: defaultPadding / 2),
                  Container(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            if (itemCount <= 0) {
                              setState(() {
                              itemCount = 0;
                            });
                            } else {
                              setState(() {
                              itemCount--;
                            });
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            size: 19.0,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 1.0, right: 10.0),
                          child: Text(
                            itemCount.toString(),
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),

                        // Add count button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              itemCount++;
                            });
                          },
                          child: Icon(
                            Icons.add,
                            size: 19.0,
                          ),
                        ),

                      ],
                    )
                ),
                  // Row(
                  //   children: const [
                  //     ColorDot(
                  //       color: Color(0xFFBEE8EA),
                  //       isActive: false,
                  //     ),
                  //     ColorDot(
                  //       color: Color(0xFF141B4A),
                  //       isActive: true,
                  //     ),
                  //     ColorDot(
                  //       color: Color(0xFFF4E5C3),
                  //       isActive: false,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: defaultPadding * 2),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.product.toBuy = itemCount;
                          widget.customFunction(widget.product, itemCount);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: const StadiumBorder()),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}