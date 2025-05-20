import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';
import '../../../../domain/usecases/auth/register_usecase.dart';
import '../../../../domain/usecases/auth/get_profile_usecase.dart';
import '../../../../domain/usecases/auth/update_profile_usecase.dart';
import '../../../../domain/usecases/auth/delete_account_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  LoginBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.deleteAccountUseCase,
  }) : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUseCase(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        await registerUseCase(event.name, event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GetProfileRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await getProfileUseCase();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<UpdateProfileSubmitted>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await updateProfileUseCase(event.name, event.email);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<DeleteAccountRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await deleteAccountUseCase();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
