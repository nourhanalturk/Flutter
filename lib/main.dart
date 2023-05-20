import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nour/layout/news_app/news_layout.dart';
import 'package:nour/network/remote/dio_helper.dart';
import 'package:nour/sharing/bloc_observer.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/cubit/states.dart';
import 'package:nour/style/themes.dart';

import 'layout/cubit/cubit.dart';


import 'modules/shop_app/on_boarding/on_boarding.dart';
import 'modules/shop_app/shop_login_screen/shop_login.dart';
import 'network/local/cache_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
 bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {

final bool isDark ;
MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(  create: (BuildContext context)=>NewsCubit()..getBusiness(),),
        BlocProvider( create: (context) => AppCubit()..changeAppMode(
    fromShared: isDark ,
    ),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightTheme,
            darkTheme:darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: ShopLoginScreen(),
          );
        },
      ),
    );
  }
}





