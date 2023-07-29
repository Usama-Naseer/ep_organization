part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class SigningIn extends AuthenticationState {}

class SignedIn extends AuthenticationState {}

class SigningUp extends AuthenticationState {}

class SignedUp extends AuthenticationState {}

class SigningOut extends AuthenticationState {}

class SignedOut extends AuthenticationState {}

class SigningInError extends AuthenticationState {
  final String message;

  SigningInError({
    required this.message,
  });
}

class SigningUpError extends AuthenticationState {
  final String message;

  SigningUpError({
    required this.message,
  });
}

class SigningOutError extends AuthenticationState {
  final String message;

  SigningOutError({
    required this.message,
  });
}

class ForgettingPassword extends AuthenticationState {}

class ForgotPasswordSuccess extends AuthenticationState {}

class ForgotPasswordError extends AuthenticationState {
  final String message;

  ForgotPasswordError({
    required this.message,
  });
}

class GuestSigningIn extends AuthenticationState {}

class GuestSignInSuccess extends AuthenticationState {}

class GuestSignInFailed extends AuthenticationState {
  final String? message;

  GuestSignInFailed({
    required this.message,
  });
}
