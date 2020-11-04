
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List params = const []]);
}

class InitGoogleSingleSignIn extends AuthEvent {
  @override
  List<Object> get props => null;
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => null;
}

class InitGoogleSingleSignUpEvent extends AuthEvent {
  final SingleSignInDto data; // user info

  InitGoogleSingleSignUpEvent(
      this.data,
      );

  @override
  List<Object> get props => null;
}

class GoogleLogginInEvent extends AuthEvent {
  final SingleSignInDto data; // userToken

  GoogleLogginInEvent(
      this.data,
      );

  @override
  List<Object> get props => [data];
}