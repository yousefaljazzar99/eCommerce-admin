import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/Product/add_product.dart';
import 'package:ecommerce/view/widget/product_widget.dart';
import 'package:ecommerce/view/screens/category/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  String catId;
  ProductsScreen(this.catId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, x) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => AddProduct(catId))));
          },
          backgroundColor: GreenColors,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("المنتجات"),
          centerTitle: true,
          backgroundColor: GreenColors,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => CategoriesScreen())));
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: firestoreProvider.products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: firestoreProvider.products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ProductWidget(
                        product: firestoreProvider.products[index],
                        catId: catId),
                  );
                },
              ),
      );
    });
  }
}
