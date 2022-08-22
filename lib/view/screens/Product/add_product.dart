import 'dart:io';

import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/Product/all_products.dart';
import 'package:ecommerce/view/screens/category/categories_screen.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  String catId;
  AddProduct(this.catId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("اضافة منتج"),
          backgroundColor: GreenColors,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => CategoriesScreen())));
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          firestoreProvider.selectImage();
                        },
                        child: firestoreProvider.selectedImage == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundColor: GreenColors,
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(firestoreProvider.selectedImage!),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustumTextField(
                          titel: "الاسم",
                          validtor: authProvider.nullValidation,
                          controller: firestoreProvider.productNameController,
                          suffix: Icon(Icons.category_rounded),
                          hidepassword: false,
                          textInputType: TextInputType.text),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: CustumTextField(
                          titel: "الوصف",
                          validtor: authProvider.nullValidation,
                          controller:
                              firestoreProvider.productDescriptionController,
                          suffix: Icon(Icons.description),
                          textInputType: TextInputType.text,
                          hidepassword: false,
                        ),
                      ),
                      CustumTextField(
                          titel: "السعر",
                          validtor: authProvider.nullValidation,
                          controller: firestoreProvider.productPriceController,
                          suffix: Icon(Icons.attach_money_rounded),
                          hidepassword: false,
                          textInputType: TextInputType.number),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: CustumTextField(
                          titel: "الكمية",
                          validtor: authProvider.nullValidation,
                          controller:
                              firestoreProvider.productQuantityController,
                          suffix: Icon(Icons.production_quantity_limits),
                          textInputType: TextInputType.number,
                          hidepassword: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          firestoreProvider.addNewProduct(catId);
                        },
                        child: Text('اضافة منتج جديد'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                firestoreProvider.getAllProduct(catId);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ProductsScreen(catId))));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(GreenColors),
                              ),
                              child: const Text("عرض المنتجات >")),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
