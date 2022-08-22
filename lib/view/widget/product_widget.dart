import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/Product/update_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  String catId;
  ProductWidget({required this.product, required this.catId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade100,
            ),
            height: 60,
            width: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.image),
            ),
          ),
          // SizedBox(
          //     height: 200,
          //     width: double.infinity,
          //     child: Image.network(
          //       product.image,
          //       fit: BoxFit.cover,
          //     )),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    color: GreenColors,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<FirestoreProvider>(context, listen: false)
                              .productNameController
                              .text = product.name;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => UpdateProduct(
                                      product: product, catId: catId))));
                        },
                        color: GreenColors,
                        icon: Icon(Icons.edit)),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<FirestoreProvider>(context, listen: false)
                              .deleteProduct(product, catId);
                        },
                        color: GreenColors,
                        icon: const Icon(Icons.delete_rounded)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
