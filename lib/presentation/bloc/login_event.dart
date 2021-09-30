part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends LoginEvent {
  final String username;
  final String password;
  const LoginUser({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class LogOut extends LoginEvent {}
