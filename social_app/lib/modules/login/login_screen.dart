import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/login/cubit/login_state.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/local/shared_preferences.dart';

import '../../shared/components/constants.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(msg: state.error, color: Colors.red);
          }
          if (state is LoginSuccessState) {
            CacheHelper.setData(value: state.uId, key: 'uId').then((value) {
              uId = state.uId;
              HomeCubit.get(context).getUserData();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayout()),
                  (route) => false);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Login to Shoppie',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey)),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: Icon(
                                LineIcons.facebook,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.deepOrange,
                              child: Icon(
                                LineIcons.googlePlus,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black,
                              child: Icon(
                                LineIcons.apple,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Or'),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Container(
                                height: 1,
                                color: Colors.grey[300],
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: defaultInput(
                                controller: emailController,
                                hint: 'Email',
                                onSubmit: (s) {},
                                label: '',
                                validator: (s) {
                                  if (s.isEmpty) {
                                    return 'Email must not be empty';
                                  }
                                },
                                type: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Password',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: defaultInput(
                                hint: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      LoginCubit.get(context)
                                          .changeVisibility();
                                    },
                                    icon: Icon(LoginCubit.get(context)
                                        .visibilityIcon)),
                                controller: passwordController,
                                onSubmit: (s) {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                obsecure: LoginCubit.get(context).obsecure,
                                label: '',
                                validator: (s) {
                                  if (s.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                },
                                type: TextInputType.visiblePassword,
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Center(
                                child: Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  state is LoginLoadingState,
                              widgetBuilder: (context) =>
                                  CircularProgressIndicator(),
                              fallbackBuilder: (context) => defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).loginUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login',
                                context: context,
                                radius: 15,
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
