import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_DB.dart';
import 'package:money_management_app/db/transaction/transaction_DB.dart';
import 'package:money_management_app/models/category/Category_Model.dart';
import 'package:money_management_app/models/transaction/Transaction_Model.dart';
import 'package:money_management_app/screeens/category/categoryAddButton.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  final _purposeEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  String? _categoryID;

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _purposeEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  label: Text(
                    "Purpose",
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 13,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder()),
              cursorColor: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _amountEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  label: Text(
                    "Amount",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder()),
              cursorColor: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());

                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              label: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : _selectedDate.toString(),
                style: const TextStyle(color: Colors.green),
              ),
              icon: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.green,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategoryType,
                      activeColor: Colors.green, 
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      activeColor: Colors.green, 
                      
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.expense;
                          _categoryID = null;
                        });
                      },
                    ),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton(
                hint: const Text('Selected Category'),
                value: _categoryID,
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListner
                        : CategoryDB().expenseCategoryListListner)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      print(e.toString());
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                }),
            const SizedBox(
              height: 50,
            ),
            CategoryPopupButton(
              onTap: () {
                addTransaction();
              },
              text: 'Submit',
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeEditingController.text;
    final _amountText = _amountEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final _parseAmount = double.tryParse(_amountText);
    if (_parseAmount == null) {
      return;
    }
    // _selectedDate
    //_selectedCategoryType
    //_categoryID

   final _model= TransactionModel(
        purpose: _purposeText,
        amount: _parseAmount,
        date: _selectedDate!,
        type: _selectedCategoryType!,
        category: _selectedCategoryModel!,);

       await TransactionDB.instance.addTransaction(_model);
       Navigator.of(context).pop();
       TransactionDB.instance.refresh();
  }
}
