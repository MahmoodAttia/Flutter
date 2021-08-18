import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    nameController.text = HomeCubit.get(context).userModel!.name!;
    bioController.text = HomeCubit.get(context).userModel!.bio!;
    phoneController.text = HomeCubit.get(context).userModel!.phone!;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomePickImageSuccessState) {
          HomeCubit.get(context).uploadImage(
              name: nameController.text,
              bio: bioController.text,
              phone: phoneController.text);
        }
        if (state is HomePickCoverSuccessState) {
          HomeCubit.get(context).uploadCover(
              name: nameController.text,
              bio: bioController.text,
              phone: phoneController.text);
        }
      },
      builder: (context, state) {
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text('Edit Profile'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.updateUserData(
                        bio: bioController.text,
                        cover: cubit.userModel!.cover!,
                        email: cubit.userModel!.email!,
                        image: cubit.userModel!.image!,
                        phone: phoneController.text,
                        name: nameController.text);
                  },
                  child: Text('UPDATE')),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 260,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${cubit.userModel!.cover}'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    cubit.pickCoverImage();
                                  },
                                  icon: Icon(IconBroken.Camera),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 85,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 80,
                                  backgroundImage: NetworkImage(
                                      '${cubit.userModel!.image}')),
                            ),
                            CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).pickImageProfile();
                                },
                                icon: Icon(IconBroken.Camera),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultInput(
                    controller: nameController,
                    onSubmit: (s) {},
                    validator: (String s) {
                      if (s.isEmpty) {
                        return 'Name must not be empty';
                      }
                    },
                    label: 'Name',
                    type: TextInputType.name,
                    prefixIcon: IconBroken.User,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultInput(
                      prefixIcon: IconBroken.Info_Circle,
                      controller: bioController,
                      onSubmit: (s) {},
                      validator: (String s) {
                        if (s.isEmpty) {
                          return 'Bio must not be empty';
                        }
                      },
                      label: 'Bio',
                      type: TextInputType.name),
                  SizedBox(
                    height: 10,
                  ),
                  defaultInput(
                    prefixIcon: IconBroken.Call,
                    controller: phoneController,
                    onSubmit: (s) {},
                    validator: (String s) {
                      if (s.isEmpty) {
                        return 'Bio must not be empty';
                      }
                    },
                    label: 'Phone',
                    type: TextInputType.phone,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
