import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_DB.dart';
import 'package:money_management_app/screeens/category/Expense_category.dart';
import 'package:money_management_app/screeens/category/Income_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            dividerColor: Colors.green,
            indicatorColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: const [
              Tab(
                height: 50,
                text: 'Income',
              ),
              Tab(
                height: 50,
                text: 'Expense',
              ),
            ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: const [IncomeCategoryList(), ExpenseCategoryList()]),
        )
      ],
    );
  }
}
