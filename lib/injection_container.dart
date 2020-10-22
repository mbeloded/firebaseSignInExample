
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_sign_in_firestore/data/datasources/local_data_source.dart';
import 'package:single_sign_in_firestore/data/datasources/remote_data_source.dart';
import 'package:single_sign_in_firestore/data/repositories/repository_impl.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';
import 'package:single_sign_in_firestore/domain/usecases/authenticate_with_google_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signin_google_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signout_google_account_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signup_google_usecase.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';

import 'presentation/bloc/auth_bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  //Blocs
  getIt.registerLazySingleton(() => AuthBloc(
      getIt(),
      getIt(),
      getIt(),
      getIt()
  ));
  getIt.registerLazySingleton(() => NavBloc(getIt()));

  //Use cases
  getIt.registerLazySingleton(() => SignInGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => AuthenticateWithGoogleUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutGoogleAccountUseCase(getIt()));

  //Data sources
  getIt.registerLazySingleton<Repository>(() => RepositoryImpl(
      localDataSource: getIt(), remoteDataSource: getIt()));

  getIt.registerLazySingleton<RemoteDataSource>(
          () => RemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImpl(getIt()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

}