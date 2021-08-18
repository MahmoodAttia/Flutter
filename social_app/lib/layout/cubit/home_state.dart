part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetUserSuccessfulState extends HomeState {
  final UserModel userModel;

  HomeGetUserSuccessfulState(this.userModel);
}

class HomeLoadingGetUserState extends HomeState {}

class HomeErrorGetUserState extends HomeState {}

class ChangeBottomNavState extends HomeState {}

class HomePickImageSuccessState extends HomeState {}

class HomePickImageErrorState extends HomeState {}

class HomePickCoverSuccessState extends HomeState {}

class HomePickCoverErrorState extends HomeState {}

class HomeUploadProfileSuccessState extends HomeState {}

class HomeUploadProfileErrorState extends HomeState {}

class HomeUploadCoverSuccessState extends HomeState {}

class HomeCoverUploadLoadingState extends HomeState {}

class HomeImageUploadLoadingState extends HomeState {}

class HomeClosePostImageState extends HomeState {}

class HomeGetUsersSuccessfulState extends HomeState {}

class HomeLoadingGetUsersState extends HomeState {}

class HomeErrorGetUsersState extends HomeState {}

class HomeSuccessSendMessageState extends HomeState {}

class HomeSuccessGetMessageState extends HomeState {}

class HomeErrorSendMessageState extends HomeState {}

class HomePickChatSuccessState extends HomeState {}

class HomePickChatErrorState extends HomeState {}

class HomeCloseChatImageState extends HomeState {}
