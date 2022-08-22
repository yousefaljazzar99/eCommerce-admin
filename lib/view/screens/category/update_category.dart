import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/category/categories_screen.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategory extends StatelessWidget {
  Category category;

  UpdateCategory({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("تعديل القائمة"),
          centerTitle: true,
          backgroundColor: GreenColors,
          actions: [
            IconButton(
              onPressed: () {
                AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
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
                                    backgroundImage:
                                        NetworkImage(category.imageUrl),
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
                              titel: "اسم القائمة",
                              validtor: firestoreProvider.nullValidation,
                              controller:
                                  firestoreProvider.categoryNameController,
                              suffix: const Icon(Icons.category_rounded),
                              hidepassword: false,
                              textInputType: TextInputType.text),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                firestoreProvider.updateCategory(category);
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: ((context) =>
                                //             CategoriesScreen())));
                              },
                              child: const Text("تحديث القائمة")),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    firestoreProvider.getAllCategories();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CategoriesScreen())));
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(GreenColors),
                                  ),
                                  child: const Text("عرض القوائم >")),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
