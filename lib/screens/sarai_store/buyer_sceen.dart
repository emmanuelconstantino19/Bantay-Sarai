import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';
import 'categories.dart';

import '../../../constants.dart';
import 'product_card.dart';
import 'section_title.dart';
import 'details_screen.dart';
import 'checkout_screen.dart';

import 'package:badges/badges.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/models/Product.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({Key key}) : super(key: key);

  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  EthereumUtils ethUtils = EthereumUtils();
  List<Product> cart = [];

  @override
  void initState() {
    ethUtils.initial();
    super.initState();
  }

  Stream<QuerySnapshot> getItemsStreamSnapshotsByDate(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('storeItems').orderBy('createdAt',descending: true).snapshots();
  }

  Stream<QuerySnapshot> getItemsStreamSnapshotsBySold(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('storeItems').orderBy('sold',descending: true).snapshots();
  }

  void addToCart(Product record, int itemCount){
    setState((){
      bool present = false;

      for(var i=0;i<cart.length;i++) {
          // you may have to check the equality operator
          if(cart[i].id == record.id) {
            cart[i].toBuy = itemCount;
            present=true;
            break;
          }
      }

      if(!present)
        cart.add(record);
      else
        print("Record already in cart");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("SARAi Store",style: TextStyle(color: Colors.black54),),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed:(){},
              icon: const Icon(
                Icons.menu,
                color: Colors.black54,
              ),
            ),
          actions: [
            Badge(
              position: BadgePosition.topEnd(top: 20, end: 0),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                cart.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black54,), onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    CheckoutScreen(cart: cart)
                ));
              }),
            )
            // IconButton(
            //   icon: const Icon(
            //     Icons.shopping_cart,
            //     color: Colors.black54,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Text(
                "best Crops for you",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: defaultPadding),
              //   child: SearchForm(),
              // ),
              const Categories(),
              // New Arrival
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SectionTitle(
                      title: "New Arrival",
                      pressSeeAll: () {},
                    ),
                  ),
                  StreamBuilder(
                    stream: getItemsStreamSnapshotsByDate(context),
                    builder: (content, snapshot){
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data.docs.length == 0){
                        return Center(child: Text("No items added yet", style: TextStyle(fontSize: 18),),);
                      }
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            snapshot.data.docs.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: defaultPadding),
                              child: ProductCard(
                                title: snapshot.data.docs[index]['name'],
                                image: null,
                                price: int.parse(snapshot.data.docs[index]['price']),
                                bgColor: Colors.white,
                                press: () {
                                  Product product = new Product(
                                    snapshot.data.docs[index].id,
                                    null,
                                    snapshot.data.docs[index]['name'],
                                    snapshot.data.docs[index]['description'],
                                    snapshot.data.docs[index]['stock'],
                                    snapshot.data.docs[index]['address'],
                                    snapshot.data.docs[index]['price'],
                                    snapshot.data.docs[index]['category'],
                                    0
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(product: product, customFunction: addToCart),
                                      ));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),

              // Popular products
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SectionTitle(
                      title: "Popular",
                      pressSeeAll: () {},
                    ),
                  ),
                  StreamBuilder(
                    stream: getItemsStreamSnapshotsBySold(context),
                    builder: (content, snapshot){
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data.docs.length == 0){
                        return Center(child: Text("No items added yet", style: TextStyle(fontSize: 18),),);
                      }
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            snapshot.data.docs.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: defaultPadding),
                              child: ProductCard(
                                title: snapshot.data.docs[index]['name'],
                                image: null,
                                price: int.parse(snapshot.data.docs[index]['price']),
                                bgColor: Colors.white,
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
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
        
        
        // Container(
        //   child: ElevatedButton(
        //           child: Padding(
        //             padding: EdgeInsets.all(16.0),
        //             child: Text('Transfer Tokens'),
        //           ),
        //           onPressed: () async {
        //             await ethUtils.sendEth(7);
        //             print("Successful!");
        //           },
        //         ),
        // ),
    );
  }
}