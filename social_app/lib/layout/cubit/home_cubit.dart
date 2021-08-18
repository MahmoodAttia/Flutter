import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    ChatsScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Chats',
    'Settings',
  ];
  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 0) getUsers();

    emit(ChangeBottomNavState());
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();
  void pickImageProfile() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(HomePickImageSuccessState());
    } else {
      print('No image selected');
      emit(HomePickImageErrorState());
    }
  }

  File? coverImage;
  void pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomePickCoverSuccessState());
    } else {
      print('No image selected');
      emit(HomePickCoverErrorState());
    }
  }

  File? chatImage;

  void pickChatImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      chatImage = File(pickedImage.path);
      emit(HomePickChatSuccessState());
    } else {
      print('No image selected');
      emit(HomePickChatErrorState());
    }
  }

  Future uploadChatImage({
    required String receiverId,
    required String text,
  }) async {
    emit(HomeImageUploadLoadingState());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(receiverId: receiverId, text: text, image: value);
      });
      emit(HomeUploadProfileSuccessState());
    });
  }

  Future uploadImage({
    required String name,
    required String bio,
    required String phone,
  }) async {
    emit(HomeImageUploadLoadingState());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, bio: bio, phone: phone, image: value);
      });
      emit(HomeUploadProfileSuccessState());
    });
  }

  void uploadCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(HomeCoverUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, bio: bio, phone: phone, cover: value);
      });
      emit(HomeUploadCoverSuccessState());
    });
  }

  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? email,
    String? cover,
    String? image,
    String? uid,
  }) {
    UserModel model = UserModel(
      bio: bio,
      name: name,
      phone: phone,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uid: userModel!.uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    });
  }

  // void closePostImage() {
  //   postImage = null;
  //   emit(HomeClosePostImageState());
  // }

  // void uploadPostImage({
  //   required String text,
  // }) {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  //       .putFile(postImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       createPost(text: text, postImage: value);
  //       emit(HomeUploadPostImageSuccessState());
  //     });
  //   });
  // }

  UserModel? userModel;
  Future getUserData() async {
    emit(HomeLoadingGetUserState());
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      getUsers();
      emit(HomeGetUserSuccessfulState(userModel!));
    }).catchError((onError) {
      print(onError);
      emit(HomeErrorGetUserState());
    });
  }

  List<UserModel> allUsers = [];
  void getUsers() {
    allUsers = [];
    emit(HomeLoadingGetUsersState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uid'] != userModel!.uid)
          allUsers.add(UserModel.fromJson(element.data()));
      });
      emit(HomeGetUsersSuccessfulState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    String? image,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      recieverId: receiverId,
      senderId: userModel!.uid,
      image: image ?? '',
      dataTime: DateFormat.Hms().format(DateTime.now()).toString(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      chatImage = null;

      emit(HomeSuccessSendMessageState());
    }).catchError((error) {
      emit(HomeErrorSendMessageState());
      print(error);
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      chatImage = null;
      emit(HomeSuccessSendMessageState());
    }).catchError((error) {
      emit(HomeErrorSendMessageState());
      print(error);
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        emit(HomeSuccessGetMessageState());
      });
    });
  }

  void closeChatImage() {
    chatImage = null;
    emit(HomeCloseChatImageState());
  }
}
