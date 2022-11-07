import 'package:flutter/material.dart';
import 'package:bantay_sarai/models/Product.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cart;

  const CheckoutScreen({ Key key, @required this.cart}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LunchState();

}

class LunchState extends State<CheckoutScreen> {
  int total = 0;

  @override
  void initState() {
    getTotal();
    super.initState();
  }

  getTotal(){
    setState(() {
      total = 0;
      for(var item in widget.cart){
        total += (item.toBuy * int.parse(item.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: initScreen()
    );
  }

  initScreen() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
                children: <Widget>[
                  for(var item in widget.cart) dummyDataOfListView(item),
                ],
              ),
          ),
          Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Total: ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    total.toString() + " SRB",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),

            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyOrdersScreen()));
                      }, // When Click on Button goto Login Screen

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 350.0, minHeight: 40.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            'Buy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                              fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
                    )
                )
            ),
            SizedBox(height:30)
        ],
      ),
    );
  }

  dummyDataOfListView(Product item) {
    return Container(
        child: Card(
          elevation: 4.0,
          margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
          color: Color(0xffFFFFFF),
          child: ListTile(
            // on ListItem clicked
            onTap: () {},

            // Image of ListItem
            // leading: Container(
            //   child: Image(
            //     fit: BoxFit.fitHeight,
            //     image: AssetImage(imgSrc),
            //   ),
            // ),

            // Lists of titles
            title: Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 80.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      item.category,
                      style: TextStyle(
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      item.price,
                      style: TextStyle(
                          color: Color(0xff374ABE)
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Item Add and Remove Container
            subtitle: Container(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (item.toBuy <= 0) {
                          setState(() {
                            item.toBuy = 0;
                            getTotal();
                          });
                        } else {
                          setState(() {
                            item.toBuy--;
                            getTotal();
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
                        item.toBuy.toString(),
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),

                    // Add count button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                            item.toBuy++;
                            getTotal();
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

            // trailing shows the widget on the right corner of the list item
            trailing: Icon(
                Icons.cancel
            ),
          ),
        )
    );
  }

}