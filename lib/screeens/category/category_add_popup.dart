import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_DB.dart';
import 'package:money_management_app/models/category/Category_Model.dart';
import 'package:money_management_app/screeens/category/categoryAddButton.dart';

ValueNotifier<CategoryType> selectedcategoryNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (cxt) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: const InputDecoration(
                    label: Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.green, ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.green, ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder()),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(
                    title: 'Income',
                    type: CategoryType.income,
                  ),
                  RadioButton(
                    title: 'Expense',
                    type: CategoryType.expense,
                  ),
                ],
              ),
            ),
            CategoryPopupButton(

              onTap: () {
                final _name = _nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }
                final _type = selectedcategoryNotifier.value;
              final _category =  CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type);
                    CategoryDB.instance.insertCategory(_category);
                    Navigator.of(cxt).pop();
              },
              text: 'Add',
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedcategoryNotifier,
            builder:
                (BuildContext context, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  activeColor:Colors.green,
                  value: type,
                  groupValue: newCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedcategoryNotifier.value = value;
                    selectedcategoryNotifier.notifyListeners();
                  });
            }),
        Text(title),
      ],
    );
  }
}
