
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/domain/entities/error_dto.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/usecases/authenticate_with_google_usecase.dart';
import 'package:single_sign_in_firestore/domain/usecases/signout_google_account_usecase.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:dartz/dartz.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  // Google Sign in
  AuthenticateWithGoogleUseCase authenticateWithGoogleUseCase;
  SignOutGoogleAccountUseCase signOutGoogleAccountUseCase;

  AuthBloc(this.authenticateWithGoogleUseCase);

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
              (data) => new GoogleLogInState(data));
    } else if (event is GoogleLoginEvent) {

      // yield SingleSignOnLoadingLoginState();

      String userToken = event.data;
      final res = await signInGoogleUseCase(userToken);

      yield res.fold(
            (failure) => _getError(failure),
            (data) => _getSingleSignInLoginState(data),
      );
    }
  }

  //for registration : await Firestore.instance.collection('users').document(user.uid).setData({ 'firstName': _firstName'})

  Future<Either<ErrorGoogleLoginState, String>> _doLogin() async {
    try {
      final result = await authenticateWithGoogleUseCase();
      if (result != null) {
        return _getTokenRequest(result);
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