import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/components/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/local/shared_preferences.dart';
import 'package:social_app/shared/network/dio_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(msg: 'Background Message', color: Colors.green);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  DioHelper.init();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(msg: 'onMessageOpenedApp Message', color: Colors.green);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  Widget? startWidget;
  if (uId != null) {
    startWidget = HomeLayout();
  } else {
    startWidget = LoginScreen();
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData()
      //..getUsers(),,
      ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: IconThemeData(size: 30),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedIconTheme: IconThemeData(color: defaultColor, size: 30),
            selectedItemColor: defaultColor,
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: defaultColor,
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          fontFamily: 'Jannah',
        ),
        home: widget,
      ),
    );
  }
}
