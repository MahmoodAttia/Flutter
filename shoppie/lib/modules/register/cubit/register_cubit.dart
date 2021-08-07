import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppie/models/login_model.dart';
import 'package:shoppie/shared/remote/dio_helper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel registerModel;
  void registerUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      path: 'register',
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(registerModel));
      print(registerModel.message);
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorState());
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
