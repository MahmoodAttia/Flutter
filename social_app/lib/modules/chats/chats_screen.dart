import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/detailschat/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                HomeCubit.get(context).allUsers != null &&
                HomeCubit.get(context).userModel != null,
            widgetBuilder: (context) {
              return Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.amber,
                      child: Row(
                        children: [
                          Icon(IconBroken.Info_Circle),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Please verify your email!'),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  showToast(
                                      msg: 'Check your inbox',
                                      color: Colors.green);
                                });
                              },
                              child: Text('Send'))
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildChatItem(
                        context, HomeCubit.get(context).allUsers[index]),
                    itemCount: HomeCubit.get(context).allUsers.length,
                  ),
                ],
              );
            },
            fallbackBuilder: (context) => SizedBox(
                  height: 15,
                ));
      },
    );
  }
}

Widget buildChatItem(context, UserModel model) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatDetailsScreen(
                    userModel: model,
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(model.image!),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(height: 1.4),
                )))
      ]),
    ),
  );
}
