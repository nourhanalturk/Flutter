import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/cubit/cubit.dart';
import 'package:nour/layout/shop_app/cubit/states.dart';
import 'package:nour/modules/shop_app/search/search_screen.dart';
import 'package:nour/sharing/sharing.component/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context, state) {

     },
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'shop layout',
            ),
            actions: [IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search))],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
              items:const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings'
                ),
              ],
            onTap: (index) {
              cubit.changeBottom(index);
            },

          ),
          body: cubit.bottomScreens[cubit.currentIndex],
        );
      },
    );
  }
}
