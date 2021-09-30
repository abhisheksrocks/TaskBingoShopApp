part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class NotLoggedIn extends LoginState {}

class LoggedIn extends LoginState {
  final User currentUser;
  const LoggedIn({
    required this.currentUser,
  });

  @override
  List<Object> get props => [currentUser];
}

class Loading extends LoginState {}

class LoginError extends LoginState {
  final String message;
  const LoginError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
