import 'package:ecommerce/Provider/auth_provider.dart';
import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/CategoriesScreen.dart';
import 'package:ecommerce/view/widget/custum_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة قائمة جديدة"),
        centerTitle: true,
        backgroundColor: GreenColors,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => CategoriesScreen())));
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body:
          Consumer<FirestoreProvider>(builder: (context, firestorProvider, x) {
        return Center(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 30),
              firestorProvider.selectedImage == null
                  ? InkWell(
                      onTap: () => firestorProvider.selectImage(),
                      child: const CircleAvatar(
                        backgroundColor: GreenColors,
                        radius: 50,
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => firestorProvider.selectImage(),
                      child: CircleAvatar(
                        backgroundImage:
                            FileImage(firestorProvider.selectedImage!),
                        radius: 50,
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: firestorProvider.categoryKey,
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustumTextField(
                            titel: "الاسم",
                            validtor: firestorProvider.nullValidation,
                            controller: firestorProvider.categoryNameController,
                            suffix: const Icon(Icons.category_rounded),
                            hidepassword: false,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              firestorProvider.addNewCategory();
                            },
                            child: const Text("اضافة قائمة")),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  firestorProvider.getAllCategories();
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
                      ]),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ]),
          ),
        );
      }),
    );
  }
}
