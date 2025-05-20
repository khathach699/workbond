import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:workbond/core/validator/auth_validator.dart';
import 'package:workbond/domain/usecases/auth/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final Logger _logger = Logger();

  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      _logger.i(
          'LoginSubmitted event: email=${event.email}, password=${event.password}');

      final emailError = AuthValidator.validateEmail(event.email);
      if (emailError != null) {
        _logger.w('Email validation error: $emailError');
        emit(AuthError(emailError));
        return;
      }

      final passwordError = AuthValidator.validatePassword(event.password);
      if (passwordError != null) {
        _logger.w('Password validation error: $passwordError');
        emit(AuthError(passwordError));
        return;
      }

      emit(AuthLoading());
      try {
        _logger.i('Calling loginUseCase...');
        await _loginUseCase(event.email, event.password);
        _logger.i('Login successful');
        emit(AuthSuccess());
      } catch (e) {
        _logger.e('Login failed: $e');
        emit(AuthError(e.toString()));
      }
    });
  }
}
