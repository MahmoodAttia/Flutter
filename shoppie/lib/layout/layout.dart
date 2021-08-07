import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/search/search_screen.dart';

import '../modules/carts/carts_screen.dart';
import '../modules/favorites/favorites_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/settings/settings_screen.dart';
import 'cubit/shop_cubit.dart';
import 'cubit/shop_state.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Widget> screens = [
          HomeScreen(),
          FavouritesScreen(),
          CartsScreen(),
          SettingsScreen(),
        ];
        List<String> titles = [
          'Shoppie',
          'Favourites',
          'Cart',
          'Settings',
        ];
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[ShopCubit.get(context).currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          body: screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: ShopCubit.get(context).currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              onTap: (index) {
                ShopCubit.get(context).changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 33,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    size: 33,
                  ),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                    size: 33,
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 33,
                  ),
                  label: 'Settings',
                ),
              ]),
        );
      },
    );
  }
}
