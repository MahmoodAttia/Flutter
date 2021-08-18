abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class LoginLoadingState extends LoginState {}

class LoginChangeVisiblityState extends LoginState {}
