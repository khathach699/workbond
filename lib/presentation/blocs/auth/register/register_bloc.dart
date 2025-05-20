import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:workbond/core/error/exceptions.dart';
import 'package:workbond/core/validator/auth_validator.dart';
import 'package:workbond/presentation/blocs/auth/register/register_event.dart';
import 'package:workbond/presentation/blocs/auth/register/register_state.dart';
import '../../../../domain/usecases/auth/register_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final Logger _logger = Logger();

  RegisterBloc({required RegisterUseCase registerUseCase})
      : _registerUseCase = registerUseCase,
        super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      _logger.i(
          'RegisterSubmitted event: fullName=${event.fullName}, email=${event.email}, password=${event.password}');

      final fullNameError = AuthValidator.validateFullName(event.fullName);
      if (fullNameError != null) {
        _logger.w('Lỗi xác thực họ tên: $fullNameError');
        emit(RegisterError(fullNameError));
        return;
      }

      final emailError = AuthValidator.validateEmail(event.email);
      if (emailError != null) {
        _logger.w('Lỗi xác thực email: $emailError');
        emit(RegisterError(emailError));
        return;
      }

      final passwordError = AuthValidator.validatePassword(event.password);
      if (passwordError != null) {
        _logger.w('Lỗi xác thực mật khẩu: $passwordError');
        emit(RegisterError(passwordError));
        return;
      }

      emit(RegisterLoading());
      try {
        _logger.i('Gọi registerUseCase...');
        await _registerUseCase(event.fullName, event.email, event.password);
        _logger.i('Đăng ký thành công');
        emit(RegisterSuccess());
      } catch (e) {
        _logger.e('Đăng ký thất bại: $e');
        String errorMessage = 'Đã xảy ra lỗi';
        if (e is DioException && e.error is String) {
          errorMessage = e.error as String;
        } else if (e is ServerException) {
          errorMessage = e.message; // Lấy message từ ServerException
        } else {
          errorMessage = e.toString();
        }
        emit(RegisterError(errorMessage));
      }
    });
  }
}
