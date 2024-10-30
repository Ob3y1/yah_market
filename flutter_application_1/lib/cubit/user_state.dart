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

class CategoriesLoading extends UserState {}
 class CategoriesSuccess extends UserState {
  final List categories;
  CategoriesSuccess(this.categories);
} class CategoriesError extends UserState {
  final String message;
  CategoriesError(this.message);
}

class ProductsLoading extends UserState {}

class ProductsSuccess extends UserState {
  final List products;

  ProductsSuccess(this.products);
}

class ProductsError extends UserState {
  final String message;

  ProductsError(this.message);
}
