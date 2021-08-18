abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {}

class RegisterCreateUserSuccessState extends RegisterState {
  final String uId;

  RegisterCreateUserSuccessState(this.uId);
}

class RegisterCreateUserErrorState extends RegisterState {}

class RegisterChangeVisiblityState extends RegisterState {}
