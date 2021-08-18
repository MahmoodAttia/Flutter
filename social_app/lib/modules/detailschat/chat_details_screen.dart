import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/home_cubit.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/dio_helper.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  const ChatDetailsScreen({required this.userModel});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Builder(
      builder: (BuildContext context) {
        HomeCubit.get(context).getMessages(receiverId: userModel.uid!);
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.1,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(userModel.name!)
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (HomeCubit.get(context).userModel!.uid ==
                                HomeCubit.get(context).messages[index].senderId)
                              return sendMessage(
                                  HomeCubit.get(context).messages[index]);
                            else
                              return recieveMessage(
                                  HomeCubit.get(context).messages[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 15,
                            );
                          },
                          itemCount: HomeCubit.get(context).messages.length),
                    ),
                    if (HomeCubit.get(context).chatImage != null)
                      Container(
                          height: 150,
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
                                              image: FileImage(
                                                  HomeCubit.get(context)
                                                      .chatImage!),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .closeChatImage();
                                        },
                                        icon: Icon(IconBroken.Close_Square),
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                    Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type your message',
                                ),
                                validator: (s) {
                                  if (s!.isEmpty) {
                                    return 'Message can\'t be empty.';
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(),
                                child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: () {
                                      if (HomeCubit.get(context).chatImage ==
                                              null &&
                                          formKey.currentState!.validate())
                                        HomeCubit.get(context).sendMessage(
                                            receiverId: userModel.uid!,
                                            text: textController.text);

                                      if (HomeCubit.get(context).chatImage !=
                                          null)
                                        HomeCubit.get(context).uploadChatImage(
                                          receiverId: userModel.uid!,
                                          text: textController.text,
                                        );
                                    },
                                    child: Icon(
                                      IconBroken.Send,
                                      color: Colors.black,
                                    ))),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: () {
                                      HomeCubit.get(context).pickChatImage();
                                    },
                                    child: Icon(
                                      IconBroken.Image,
                                      color: Colors.black,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget recieveMessage(MessageModel model) {
  if (model.image == '')
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                bottomEnd: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.text!),
            ),
          ),
          Text(
            model.dataTime!,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  else
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              image: DecorationImage(
                image: NetworkImage(model.image!),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.text!),
        ),
        Text(
          model.dataTime!,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
}

Widget sendMessage(MessageModel model) {
  if (model.image == '')
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.text!,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          Text(
            model.dataTime!,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  else
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  model.image!,
                ),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.text!),
        ),
        Text(
          model.dataTime!,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
}
