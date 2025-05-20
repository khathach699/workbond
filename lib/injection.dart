import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:workbond/core/network/api_service.dart';
import 'package:workbond/core/network/dio_client.dart';
import 'package:workbond/data/datasources/local/auth_local_datasource.dart';
import 'package:workbond/data/datasources/remote/auth_remote_datasource.dart';
import 'package:workbond/data/repositories/auth_repository.dart';
import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import 'package:workbond/domain/repositories/user_repository_impl.dart';
import 'package:workbond/domain/usecases/auth/login_usecase.dart';
import 'package:workbond/domain/usecases/auth/register_usecase.dart';
import 'package:workbond/presentation/blocs/auth/login/login_bloc.dart';
import 'package:workbond/presentation/blocs/auth/register/register_bloc.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';

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
      () => AuthLocalDataSource(sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<AuthLocalDataSource>(),
    ),
  );

  // Domain
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));

  // Presentation
  sl.registerFactory(
    () => LoginBloc(
      loginUseCase: sl<LoginUseCase>(),
    ),
  );
  sl.registerFactory(
    () => RegisterBloc(
      registerUseCase: sl<RegisterUseCase>(),
    ),
  );
  sl.registerLazySingleton(() => OnboardingBloc());
}
