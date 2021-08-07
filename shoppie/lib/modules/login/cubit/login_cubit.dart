import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoppie/models/login_model.dart';
import 'package:shoppie/shared/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      path: 'login',
      data: {
        'email': email,
        'password': password,
      },
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
      print(loginModel!.message!);
    }).catchError((onError) {
      print(onError);
      emit(LoginErrorState());
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
