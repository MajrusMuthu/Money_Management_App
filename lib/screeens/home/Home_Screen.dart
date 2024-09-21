

import 'package:flutter/material.dart';
import 'package:money_management_app/screeens/add_transaction/Add_Transaction.dart';
import 'package:money_management_app/screeens/category/category.dart';
import 'package:money_management_app/screeens/category/category_add_popup.dart';
import 'package:money_management_app/screeens/home/widget/BottomNavigation.dart';
import 'package:money_management_app/screeens/transactions/Transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [TransactionPage(), CategoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Personal Money Management',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green, ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transactions');
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print('Add Category');
            showCategoryAddPopup(context);
          }
        },
        backgroundColor:Colors.green, 
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
