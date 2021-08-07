import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/layout.dart';
import 'package:shoppie/modules/login/login_screen.dart';
import 'package:shoppie/modules/onboarding/onboaring_screen.dart';
import 'package:shoppie/shared/bloc_observer.dart';
import 'package:shoppie/shared/components/constants.dart';
import 'package:shoppie/shared/local/shared_preferences.dart';
import 'package:shoppie/shared/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.dioinit();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  var isOnBoardChecked = CacheHelper.getData(key: 'isBoardChecked');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget? widget;

  if (isOnBoardChecked != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getFavourites()
        ..getHomeData()
        ..userData()
        ..getFAQS()
        ..getCarts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: defaultColor,
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(selectedItemColor: defaultColor),
          textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black)),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Cairo',
        ),
        home: widget,
      ),
    );
  }
}
