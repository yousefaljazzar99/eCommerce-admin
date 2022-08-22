import 'package:ecommerce/Provider/firestore_provider.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/router.dart';
import 'package:ecommerce/view/screens/category/update_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            // child: TextFormField(
            //   decoration: InputDecoration(
            //     border: InputBorder.none,
            //     prefixIcon: Icon(
            //       Icons.search,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
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
              child: Image.network(category.imageUrl),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // SizedBox(
          //     height: 200,
          //     width: 280,
          //     child: Image.network(
          //       category.imageUrl,
          //       fit: BoxFit.cover,
          //     )),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(
                    color: GreenColors,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<FirestoreProvider>(context, listen: false)
                              .categoryNameController
                              .text = category.name;
                          // AppRouter.NavigateWithReplacemtnToWidget(UpdateCategory(category: category));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      UpdateCategory(category: category))));
                        },
                        color: GreenColors,
                        icon: Icon(Icons.edit)),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Provider.of<FirestoreProvider>(context, listen: false)
                              .deleteCategory(category);
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
