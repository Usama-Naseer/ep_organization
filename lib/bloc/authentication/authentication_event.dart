part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ForgotPassword extends AuthenticationEvent {
  final String email;

  ForgotPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class Register extends AuthenticationEvent {
  final String email;
  final String name;
  final String password;

  Register({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [email, name, password];
}

class GuestLogin extends AuthenticationEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
