import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/ethereum_utils.dart';
import 'categories.dart';

import '../../../constants.dart';
import 'product_card.dart';
import 'section_title.dart';
import 'details_screen.dart';
import 'checkout_screen.dart';
import 'account.dart';

import 'package:badges/badges.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bantay_sarai/models/Product.dart';

import 'package:bantay_sarai/widgets/provider_widget.dart';

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

  checkIfNumberIsSeller() async {
    bool isAccountSeller;

    await Provider
        .of(context)
        .auth
        .getCurrentUser().then((result){
          if(result.phoneNumber=="+639999999999"){
            isAccountSeller = true;
          }else{
            isAccountSeller = false;
          }
    });
    return isAccountSeller;
  }

  void removeFromCart(int index){
    setState((){
      cart.removeAt(index);
    });
  }

  void addToCart(Product record, int itemCount){
    setState((){
      bool present = false;

      for(var i=0;i<cart.length;i++) {
          // you may have to check the equality operator
          if(cart[i].id == record.id) {
            cart[i].toBuy = itemCount;
            present=true;

            if(itemCount==0){
              cart.removeAt(i);
            }
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("SARAi Store"),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed:() async {
                bool isSeller = await checkIfNumberIsSeller();
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    Account(isSeller:isSeller)
                ));
              },
              icon: const Icon(
                Icons.menu,
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
              child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                    CheckoutScreen(cart: cart, customFunction: removeFromCart)
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
          //padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.green[200],
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:8.0,left:28.0),
                    child: Image.asset(
                      'assets/logos/half_lady_sarai.png',
                      fit: BoxFit.contain,
                      height: 60,
                    ),
                  ),
                  SizedBox(width:10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                      children: [
                        TextSpan(text:'Bili na!\n', style: TextStyle(fontSize:13)),
                        TextSpan(text:'Welcome to SARAi Store!', style: TextStyle(fontSize:16)),
                      ]
                    ),
                  ),
//                          Text('Mabuhay,', style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: Colors.black)),
//                          Text(user.firstName + ' ' + user.lastName + '!', style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color: Color(0xFF369d34))),
                ],
              ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top:32, left: 16.0, right: 16.0, bottom: 16.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.w500, color: Colors.green[800]),
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
                  ],
                ),
                ),
              ),
              SizedBox(height:10),
              // New Arrival
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:16.0,left:16.0,right:16.0),
                  child: Column(
                children: [
                  SectionTitle(
                      title: "New Arrival",
                      pressSeeAll: () {},
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
                                image: snapshot.data.docs[index]['imageUrl'],
                                price: int.parse(snapshot.data.docs[index]['price']),
                                bgColor: Colors.white,
                                press: () async {
                                  int toBuy = 1;

                                  for(var i=0;i<cart.length;i++) {
                                      // you may have to check the equality operator
                                      if(cart[i].id == snapshot.data.docs[index].id) {
                                        toBuy = cart[i].toBuy;
                                        break;
                                      }
                                  }

                                  Product product = new Product(
                                    snapshot.data.docs[index].id,
                                    snapshot.data.docs[index]['imageUrl'],
                                    snapshot.data.docs[index]['name'],
                                    snapshot.data.docs[index]['description'],
                                    snapshot.data.docs[index]['stock'],
                                    snapshot.data.docs[index]['address'],
                                    snapshot.data.docs[index]['price'],
                                    snapshot.data.docs[index]['category'],
                                    snapshot.data.docs[index]['unit'],
                                    toBuy
                                  );
                                  bool isSeller = await checkIfNumberIsSeller();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(product: product, isSeller: isSeller, customFunction: addToCart),
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
                ),
              ),
              SizedBox(height:10),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:16.0,left:16.0,right:16.0),
                  child:Column(
                children: [
                  SectionTitle(
                      title: "Popular",
                      pressSeeAll: () {},
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
                                image: snapshot.data.docs[index]['imageUrl'],
                                price: int.parse(snapshot.data.docs[index]['price']),
                                bgColor: Colors.white,
                                press: () async {
                                  int toBuy = 1;

                                  for(var i=0;i<cart.length;i++) {
                                      // you may have to check the equality operator
                                      if(cart[i].id == snapshot.data.docs[index].id) {
                                        toBuy = cart[i].toBuy;
                                        break;
                                      }
                                  }

                                  Product product = new Product(
                                    snapshot.data.docs[index].id,
                                    snapshot.data.docs[index]['imageUrl'],
                                    snapshot.data.docs[index]['name'],
                                    snapshot.data.docs[index]['description'],
                                    snapshot.data.docs[index]['stock'],
                                    snapshot.data.docs[index]['address'],
                                    snapshot.data.docs[index]['price'],
                                    snapshot.data.docs[index]['category'],
                                    snapshot.data.docs[index]['unit'],
                                    toBuy
                                  );
                                  bool isSeller = await checkIfNumberIsSeller();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(product: product, isSeller: isSeller, customFunction: addToCart),
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
                )
              ),
              // Popular products
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