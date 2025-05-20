import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'core/network/api_service.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/local/auth_local_datasource.dart';
import 'data/datasources/remote/auth_remote_datasource.dart';
import 'data/repositories/auth_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/register_usecase.dart';
import 'domain/usecases/auth/get_profile_usecase.dart';
import 'domain/usecases/auth/update_profile_usecase.dart';
import 'domain/usecases/auth/delete_account_usecase.dart';
import 'presentation/blocs/auth/login/login_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FlutterSecureStorage());
  sl.registerLazySingleton(
    () => DioClient(sl<Dio>(), sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton(() => ApiService(sl<DioClient>().dio));

  // Data
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<ApiService>()));
  sl.registerLazySingleton(
    () => AuthLocalDataSource(sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<AuthLocalDataSource>(),
    ),
  );

  // Domain
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl<AuthRepository>()));

  // Presentation
  sl.registerFactory(
    () => LoginBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      getProfileUseCase: sl<GetProfileUseCase>(),
      updateProfileUseCase: sl<UpdateProfileUseCase>(),
      deleteAccountUseCase: sl<DeleteAccountUseCase>(),
    ),
  );

  // onboarding
  sl.registerLazySingleton(() => OnboardingBloc());

  //register
}
