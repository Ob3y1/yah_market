class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInloading extends UserState {}

final class SignInFailuer extends UserState {
  final String errMessage;

  SignInFailuer({required this.errMessage});
}

final class SignUpSuccess extends UserState {}

final class SignUploading extends UserState {}

final class SignUpFailuer extends UserState {
  final String errMessage;

  SignUpFailuer({required this.errMessage});
}

final class LogoutSuccess extends UserState {}

final class Logoutloading extends UserState {}

final class LogoutFailuer extends UserState {
  final String errMessage;

  LogoutFailuer({required this.errMessage});
}
final class GetUserLoading extends UserState {}
final class GetUserSuccess extends UserState {}
final class GetUserFailure extends UserState {
    final String errMessage;

  GetUserFailure({required this.errMessage,});
}
