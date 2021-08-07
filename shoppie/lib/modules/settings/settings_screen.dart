import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/modules/faqs/faqs_screen.dart';
import 'package:shoppie/modules/login/login_screen.dart';
import 'package:shoppie/modules/update_user/update_user_screen.dart';
import 'package:shoppie/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Hello, ${ShopCubit.get(context).loginModel!.data!.name}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).logout().then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                              print(token);
                            });
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            color: defaultColor,
                          ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    settingsItem(Icons.person, 'Update Profile', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserUpdateScreen()));
                    }),
                    settingsItem(Icons.question_answer, 'FAQs', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FaqsScreen()));
                    }),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget settingsItem(IconData icon, String title, Function function) {
    return InkWell(
      onTap: () => function(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.grey[200]!.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                  radius: 30,
                  backgroundColor: defaultColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
