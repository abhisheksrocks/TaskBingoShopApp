import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/error_messages.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Api api;
  LoginBloc({required this.api}) : super(NotLoggedIn()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is LoginUser) {
          emit(Loading());
          final response = await api.login(
              username: event.username, password: event.password);

          response.fold(
            (failure) =>
                emit(const LoginError(message: ErrorMessages.INVALID_USER)),
            (user) => emit(LoggedIn(
              currentUser: user,
            )),
          );
        } else if (event is LogOut) {
          emit(Loading());
          final response = await api.logout();

          response.fold(
            (failure) =>
                emit(const LoginError(message: ErrorMessages.LOGOUT_FAILURE)),
            (value) => emit(NotLoggedIn()),
          );
        }
      },
    );
  }
}
