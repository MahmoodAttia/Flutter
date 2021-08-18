import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/layout/layout.dart';
import 'package:social_app/modules/register/cubit/register_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/local/shared_preferences.dart';

import '../../shared/components/constants.dart';
import 'cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterCreateUserSuccessState) {
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
            appBar: AppBar(),
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
                            'Register to Shoppie',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                                prefixIcon: Icons.email,
                                onSubmit: (s) {
                                  return 'ad';
                                },
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
                                prefixIcon: Icons.password_outlined,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      RegisterCubit.get(context)
                                          .changeVisibility();
                                    },
                                    icon: Icon(RegisterCubit.get(context)
                                        .visibilityIcon)),
                                controller: passwordController,
                                onSubmit: (s) {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).registerUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                obsecure: RegisterCubit.get(context).obsecure,
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
                              height: 20,
                            ),
                            Text('Name',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: defaultInput(
                                prefixIcon: Icons.person,
                                controller: nameController,
                                onSubmit: (s) {},
                                label: '',
                                validator: (s) {
                                  if (s.isEmpty) {
                                    return 'Name must not be empty';
                                  }
                                },
                                type: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Phone',
                                style: Theme.of(context).textTheme.headline6),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: defaultInput(
                                prefixIcon: Icons.phone,
                                controller: phoneController,
                                onSubmit: (s) {},
                                label: '',
                                validator: (s) {
                                  if (s.isEmpty) {
                                    return 'Phone must not be empty';
                                  }
                                },
                                type: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Center(
                                child: Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  state is RegisterLoadingState,
                              widgetBuilder: (context) =>
                                  CircularProgressIndicator(),
                              fallbackBuilder: (context) => defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).registerUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Register',
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
