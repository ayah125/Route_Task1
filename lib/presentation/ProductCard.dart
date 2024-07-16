// product_card.dart
import 'package:c_route_task/presentation/cartScreen.dart';
import 'package:c_route_task/data/models/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProductCard extends StatelessWidget {
  Color color1 = Color.fromARGB(255, 46, 102, 161);
  Color color2 = Color(0xFF022166);
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    double discountedprice = (product.price) -
        (product.price * product.discountPercentage / 100).ceil();
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.topRight, children: [
              Image.network(product.thumbnail,
                  fit: BoxFit.cover, height: 160, width: double.infinity),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: color1,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color2)),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${discountedprice} EGP",
                        style: TextStyle(fontSize: 17, color: color2)),
                    Text("${product.price} EGP",
                        style: TextStyle(
                            fontSize: 17,
                            color: color1,
                            decoration: TextDecoration.lineThrough)),
                  ],
                )),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' Reviews (${product.rating})',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, color: color2),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amberAccent,
                    )
                  ],
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: FloatingActionButton(
                    backgroundColor: color2,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
