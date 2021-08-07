import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shoppie/layout/cubit/shop_cubit.dart';
import 'package:shoppie/layout/cubit/shop_state.dart';
import 'package:shoppie/shared/components/components.dart';

class UserUpdateScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    emailController.text = ShopCubit.get(context).loginModel!.data!.email!;
    phoneController.text = ShopCubit.get(context).loginModel!.data!.phone!;
    nameController.text = ShopCubit.get(context).loginModel!.data!.name!;
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateUserData) {
          if (state.updateModel.status!) {
            ShopCubit.get(context).userData();
            showToast(msg: state.updateModel.message!, color: Colors.green);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${ShopCubit.get(context).loginModel!.data!.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
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
                    Text(
                      'Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: defaultInput(
                        controller: nameController,
                        hint: 'Name',
                        onSubmit: (s) {},
                        label: '',
                        validator: (s) {
                          if (s.isEmpty) {
                            return 'Nmae must not be empty';
                          }
                        },
                        type: TextInputType.name,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Phone',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: defaultInput(
                        controller: phoneController,
                        hint: 'Phone',
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
                      height: 20,
                    ),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15),
                    ),
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
                              ShopCubit.get(context).changeVisibility();
                            },
                            icon: Icon(ShopCubit.get(context).visibilityIcon)),
                        controller: passwordController,
                        obsecure: ShopCubit.get(context).obsecure,
                        label: '',
                        validator: (s) {},
                        type: TextInputType.visiblePassword,
                        onSubmit: (s) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is ShopLoadingUpdateUserData,
                      widgetBuilder: (context) => CircularProgressIndicator(),
                      fallbackBuilder: (context) => defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                email: emailController.text,
                                name: nameController.text,
                                password: passwordController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'Submit',
                        context: context,
                        radius: 15,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
