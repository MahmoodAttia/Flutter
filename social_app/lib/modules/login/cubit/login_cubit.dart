import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/login_state.dart';
import 'package:social_app/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  bool obsecure = true;
  IconData visibilityIcon = Icons.visibility;
  void changeVisibility() {
    obsecure = !obsecure;
    obsecure
        ? visibilityIcon = Icons.visibility
        : visibilityIcon = Icons.visibility_off;
    emit(LoginChangeVisiblityState());
  }
}
