import 'package:flutter/material.dart';
import 'package:money_management_app/screeens/home/Home_Screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder:(BuildContext context, int updatedIndex, Widget?_) {
        return BottomNavigationBar(backgroundColor: Colors.white,
         selectedItemColor: Colors.green, 
         unselectedItemColor: Colors.grey,
        currentIndex: updatedIndex,
        onTap: (newIndex) {
          HomeScreen.selectedIndexNotifier.value = newIndex;
        },
        items: const [
        BottomNavigationBarItem(backgroundColor:Colors.black,

          label: 'Transactions' ,
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Categories',
          icon: Icon(Icons.category_outlined),
        )
      ]);
      } ,

    );
  }
}
