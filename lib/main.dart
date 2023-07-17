import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nour/layout/shop_app/shop_layout.dart';
import 'package:nour/layout/social_app/social_layout_screen.dart';
import 'package:nour/models/social_app/cubit/cubit.dart';
import 'package:nour/network/remote/dio_helper.dart';
import 'package:nour/sharing/bloc_observer.dart';
import 'package:nour/sharing/cubit/cubit.dart';
import 'package:nour/sharing/cubit/states.dart';
import 'package:nour/sharing/sharing.component/constans.dart';
import 'package:nour/style/themes.dart';


import 'layout/news_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/shop_app/on_boarding/on_boarding.dart';
import 'modules/shop_app/shop_login_screen/shop_login.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'network/local/cache_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CacheHelper.init();
 Widget ?widget ;
  bool? isDark = CacheHelper.getData(key: 'isDark');
// bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
 //token = CacheHelper.getData(key: 'token');
 uId = CacheHelper.getData(key: 'uId');
 print(uId);

 // if(onBoarding!=null){
 //   if(token!=null){
 //     widget = ShopLayout();
 //   }else{
 //     widget = ShopLoginScreen();
 //   }
 // }else{
 //   widget =  OnBoardingScreen();
 // }

if(uId !=null){
  widget = SocialLayout();
}else{
  widget = SocialLoginScreen();
}

  runApp( MyApp(
    widget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
final Widget? widget;
final bool? isDark ;

MyApp({this.isDark ,this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(  create: (BuildContext context)=>NewsCubit()..getBusiness(),),
        BlocProvider( create: (context) => AppCubit()..changeAppMode(
    fromShared: isDark ,
    ),),
        BlocProvider(  create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData()),
        BlocProvider(  create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts()..getAllUsers()),

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
            home:widget,
          );
        },
      ),
    );
  }
}





