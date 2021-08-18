import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(email: email, uid: value.user!.uid, phone: phone, name: name);
      //emit(RegisterSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String uid,
    required String phone,
    required String name,
  }) {
    UserModel userModel = UserModel(
      email: email,
      uid: uid,
      phone: phone,
      bio: 'write your bio',
      image:
          'https://images.pexels.com/photos/2801603/pexels-photo-2801603.jpeg',
      cover:
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg',
      name: name,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uid));
    }).catchError((onError) {
      print(onError);
      emit(RegisterCreateUserErrorState());
    });
  }

  bool obsecure = true;
  IconData visibilityIcon = Icons.visibility;
  void changeVisibility() {
    obsecure = !obsecure;
    obsecure
        ? visibilityIcon = Icons.visibility
        : visibilityIcon = Icons.visibility_off;
    emit(RegisterChangeVisiblityState());
  }
}
