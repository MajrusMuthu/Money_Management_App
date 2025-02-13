import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/models/transaction/Transaction_Model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  void addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future <void>deleteTransaction(String id);

}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }

  Future<void>refresh()async{
    final _list = await getAllTransactions();
    _list.sort((first,second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
   
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

    @override
  Future<void> deleteTransaction(String id)async {
     final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();

  }
}
