
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/domain/entities/error_dto.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/domain/usecases/authenticate_with_google_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/check_if_user_persists_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signin_google_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signout_google_account_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/register_user_usecase.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  // Google Sign in
  NavBloc navBloc;
  AuthenticateWithGoogleUseCase authenticateWithGoogleUseCase;
  SignInGoogleUseCase signInGoogleUseCase;
  RegisterUserUseCase registerUserUseCase;
  CheckIfUserPersistsUseCase checkIfUserPersistsUseCase;
  SignOutGoogleAccountUseCase signOutGoogleAccountUseCase;

  AuthBloc(this.navBloc, this.authenticateWithGoogleUseCase, this.signInGoogleUseCase, this.registerUserUseCase, this.checkIfUserPersistsUseCase, this.signOutGoogleAccountUseCase);

  @override
  AuthState get initialState => InitialSignInState();

  @override
  Stream<AuthState> mapEventToState(
      AuthEvent event,
      ) async* {
    if (event is InitGoogleSingleSignIn) {
      yield AuthLoadingState();
      final res = await _doLogin();

      yield res.fold(
              (failure) => failure,
              (data) => new GoogleLogginInState(data));
    } else if (event is GoogleLogginInEvent) {

      String userToken = event.data.token;

      final res = await signInGoogleUseCase(userToken);

      yield res.fold(
            (failure) => _getError(failure),
            (data) => _getSingleSignInLoginState(data),
      );

    } else if (event is InitGoogleSingleSignUpEvent) {
      SingleSignInDto user = event.data;
      final res = await registerUserUseCase(user);

      yield res.fold(
            (failure) => _getError(failure),
            (data) => _getSingleSignUpLoginState(data),
      );
    } else if (event is LogoutEvent) {
      await signOutGoogleAccountUseCase();

      navBloc.add(NavLogin());

      yield LoggedOutState();
    }
  }

  AuthState _getSingleSignUpLoginState(SingleSignInDto data) {

    navBloc.add(NavHome());

    return GoogleLoggedInState("");
  }

  //for registration : await Firestore.instance.collection('users').document(user.uid).setData({ 'firstName': _firstName'})

  AuthState _getSingleSignInLoginState(SingleSignInDto data) {

    navBloc.add(NavHome());

    return GoogleLoggedInState("");

  }

  Future<Either<AuthState, SingleSignInDto>> _doLogin() async {
    try {
      final result = await authenticateWithGoogleUseCase();
      if (result != null) {
        final auth = await result.authentication;

        UserEntity userEntity = UserEntity(result.id, result.displayName, result.email);

        String userToken = auth.idToken;

        SingleSignInDto user = new SingleSignInDto(
            userToken,
            userEntity);

        bool isUserPresent = await checkIfUserPersistsUseCase.call(userToken);
        if (!isUserPresent) {
          signOutGoogleAccountUseCase();
          return Left(ErrorUserNotFoundState(user));
          // userRemoteDataSource.createUser(user);
        }

        return Right(user);//_getTokenRequest(result);
      } else {
        signOutGoogleAccountUseCase();
        return Left(ErrorGoogleLoginState(
            new ErrorEntity(401, "Google authentication error", "")));
      }
    } on PlatformException catch (e) {
      signOutGoogleAccountUseCase();

      return Left(ErrorGoogleLoginState(
          new ErrorEntity(401, "Google authentication error", "${e.code}, ${e.message}")));
    }
  }

  Future<Either<ErrorGoogleLoginState, String>> _getTokenRequest(GoogleSignInAccount data) async {
    final result = await data.authentication;
    if (result != null) {
      return Right(result.idToken);
    }
    signOutGoogleAccountUseCase();
    return Left(ErrorGoogleLoginState(new ErrorEntity(401, "Google authentication error", "")));
  }

  AuthState _getError(BaseFailure failure) {
    print(failure);

    if (failure is FireStoreFailure) {
      signOutGoogleAccountUseCase();
      return new ErrorUserNotFoundState(failure.data);
    }

    switch (failure.code) {
      case 401:
        signOutGoogleAccountUseCase();
        return new ErrorGoogleLoginState(new ErrorEntity(failure.code, "Unauthorised", failure.message));
      default:
        signOutGoogleAccountUseCase();
        return new ErrorGoogleLoginState(new ErrorEntity(failure.code, failure.suffix, failure.message));
    }

  }

}