import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_DB.dart';
import 'package:money_management_app/models/category/Category_Model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListner,
        builder: (BuildContext context,List<CategoryModel>newList, Widget?_) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final category = newList[index];
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDB.instance.deleteCategory(category.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: newList.length);
        });
  }
}
