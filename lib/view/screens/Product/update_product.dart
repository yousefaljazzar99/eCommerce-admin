import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/Product/all_products.dart';
import 'package:ecommerce/view/screens/category/categories_screen.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProduct extends StatelessWidget {
  Product product;
  String catId;
  UpdateProduct({required this.product, required this.catId});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("تعديل المنتج"),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            firestoreProvider.selectImage();
                          },
                          child: firestoreProvider.selectedImage == null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: GreenColors,
                                  backgroundImage: NetworkImage(product.image),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(
                                      firestoreProvider.selectedImage!),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustumTextField(
                            titel: "الاسم ",
                            validtor: authProvider.nullValidation,
                            controller: firestoreProvider.productNameController,
                            suffix: const Icon(Icons.category_rounded),
                            hidepassword: false,
                            textInputType: TextInputType.text),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                          child: CustumTextField(
                            titel: "الوصف ",
                            validtor: authProvider.nullValidation,
                            controller:
                                firestoreProvider.productDescriptionController,
                            suffix: Icon(Icons.description),
                            textInputType: TextInputType.text,
                            hidepassword: false,
                          ),
                        ),
                        CustumTextField(
                            titel: "السعر ",
                            validtor: authProvider.nullValidation,
                            controller:
                                firestoreProvider.productPriceController,
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
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              product.name = Provider.of<FirestoreProvider>(
                                      context,
                                      listen: false)
                                  .productNameController
                                  .text;
                              product.description =
                                  Provider.of<FirestoreProvider>(context,
                                          listen: false)
                                      .productDescriptionController
                                      .text;
                              Provider.of<FirestoreProvider>(context,
                                      listen: false)
                                  .productPriceController
                                  .text = product.price.toString();
                              Provider.of<FirestoreProvider>(context,
                                      listen: false)
                                  .productQuantityController
                                  .text = product.quantitiy.toString();
                              firestoreProvider.updateProduct(product, catId);
                              // Navigator.pop(context);
                            },
                            child: const Text("تعديل المنتج")),
                        const SizedBox(
                          height: 20,
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
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
