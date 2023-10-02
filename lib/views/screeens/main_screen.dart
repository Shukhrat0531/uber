import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:last_uber/views/screeens/accout_screen.dart';
import 'package:last_uber/views/screeens/cart_screen.dart';
import 'package:last_uber/views/screeens/category_screen.dart';
import 'package:last_uber/views/screeens/favorite_screen.dart';
import 'package:last_uber/views/screeens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  List<Widget> _pages = [HomeScreen(),CategoryScreen(),CartScreen(),FavoriteScreen(),AccoutScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        currentIndex: pageIndex,
        items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/store-1.png',
            width: 20,
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/explore.svg'),
          label: 'categories',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/cart.svg'),
          label: 'cart',
        ),
         BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/favorite.svg'),
          label: 'favorite',
        ),
        BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/account.svg'),
              label: 'account',
            )
      ]),
      body: _pages[pageIndex],
    );
  }
}
