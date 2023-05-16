import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nour/layout/news_layout.dart';
import 'package:nour/network/remote/dio_helper.dart';
import 'package:nour/sharing/bloc_observer.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/cubit/states.dart';

import 'layout/cubit/cubit.dart';
import 'modules/bmi_screen/bmi_screen.dart';
import 'modules/counter_screen/counter_screen.dart';
import 'modules/layout1_screen/layout_screen.dart';
import 'modules/login_screen/login_screen.dart';
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
            theme: ThemeData(

              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,

                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black87,
                  )

              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ) ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.pink,
                  unselectedItemColor: Colors.grey
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:HexColor('333739'),
                    statusBarIconBrightness: Brightness.dark,

                  ),
                  backgroundColor:HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )

              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739'),
                  selectedItemColor: Colors.pink,
                  unselectedItemColor: Colors.grey
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ) ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:NewsLayout(),
          );
        },
      ),
    );
  }
}





