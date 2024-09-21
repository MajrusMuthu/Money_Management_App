import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/models/category/Category_Model.dart';
import 'package:money_management_app/models/transaction/Transaction_Model.dart';
import 'package:money_management_app/screeens/add_transaction/Add_Transaction.dart';
import 'package:money_management_app/screeens/home/HomeAnimation.dart';
import 'package:money_management_app/screeens/home/Home_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // CategoryTypeAdapter if not already registered
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  //TransactionModel Adapter
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const AnimationPage(),
        '/HomeScreen': (context) => const HomeScreen(),
        ScreenAddTransaction.routeName: (context) => ScreenAddTransaction(),
      },
    );
  }
}
