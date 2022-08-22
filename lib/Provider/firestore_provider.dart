import 'dart:developer';
import 'dart:io';

import 'package:ecommerce/Firebase/firestore_helper.dart';
import 'package:ecommerce/Firebase/storage_helper.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/view/widget/custum_dialog.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirestoreProvider extends ChangeNotifier {
  GlobalKey<FormState> categoryKey = GlobalKey();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();

  File? selectedImage;
  List<Category> categories = [];
  List<Product> products = [];

  FirestoreProvider() {
    getAllCategories();
  }

  selectImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(xfile!.path);
    notifyListeners();
  }

  nullValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }
  }

  // ======================================== Categories =========================================================
  addNewCategory() async {
    if (categoryKey.currentState!.validate() && selectedImage != null) {
      String ImageUrlProvider =
          await StorageHelper.storageHelper.uploadImage(selectedImage!);
      Category category = Category(
          name: categoryNameController.text, imageUrl: ImageUrlProvider);
      FirestoreHelper.firestoreHelper.addNewCategory(category);
      CustumDialog.showDialogFunction("تمت الاضافة بنجاح !");
    } else if (selectedImage == null && !categoryKey.currentState!.validate()) {
      CustumDialog.showDialogFunction("قم باضافة الصورة والاسم");
    } else if (selectedImage == null) {
      CustumDialog.showDialogFunction("اضافة صورة");
    } else {
      CustumDialog.showDialogFunction("اضافة اسم");
    }
    notifyListeners();
  }

  getAllCategories() async {
    categories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  updateCategory(Category category) async {
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
    }
    Category newCategory = Category(
        name: categoryNameController.text,
        imageUrl: imageUrl ?? category.imageUrl);

    newCategory.categoryId = category.categoryId;
    await FirestoreHelper.firestoreHelper.updateCategory(newCategory);
    CustumDialog.showDialogFunction("تحديث !");
    int index = categories.indexOf(categories
        .where((element) => element.categoryId == category.categoryId)
        .first);
    categories[index] = newCategory;
    notifyListeners();
  }

  deleteCategory(Category category) async {
    await FirestoreHelper.firestoreHelper.deleteCategory(category);
    categories
        .removeWhere((element) => element.categoryId == category.categoryId);
    notifyListeners();
  }

  // ======================================== Products =========================================================
  addNewProduct(String categoryId) async {
    if (selectedImage != null) {
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage(selectedImage!);
      Product product = Product(
        name: productNameController.text,
        description: productDescriptionController.text,
        price: num.parse(productPriceController.text),
        quantitiy: num.parse(productQuantityController.text),
        image: imageUrl,
      );
      Product newProduct = await FirestoreHelper.firestoreHelper
          .addNewProduct(product, categoryId);
      products.add(newProduct);
      CustumDialog.showDialogFunction("تمت الاضافة بنجاح !");
    }
    notifyListeners();
  }

  getAllProduct(String categoryId) async {
    products = await FirestoreHelper.firestoreHelper.getAllProduct(categoryId);
    notifyListeners();
  }

  updateProduct(Product product, String categoryId) async {
    String? imageUrl;
    if (selectedImage != null) {
      imageUrl = await StorageHelper.storageHelper.uploadImage(selectedImage!);
    }
    Product newProduct = Product(
      name: productNameController.text,
      description: productDescriptionController.text,
      price: num.parse(productPriceController.text),
      quantitiy: num.parse(productQuantityController.text),
      image: imageUrl ?? product.image,
    );
    newProduct.id = product.id;
    await FirestoreHelper.firestoreHelper.updateProduct(newProduct, categoryId);
    CustumDialog.showDialogFunction("Updated !");
    getAllProduct(categoryId);
    notifyListeners();
  }

  deleteProduct(Product product, String categoryId) async {
    await FirestoreHelper.firestoreHelper.deleteProduct(product, categoryId);
    products.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }
}
