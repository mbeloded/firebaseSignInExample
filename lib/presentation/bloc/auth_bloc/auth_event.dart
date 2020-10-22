
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List params = const []]);
}

class InitGoogleSingleSignIn extends AuthEvent {
  @override
  List<Object> get props => null;
}

class InitGoogleSingleSignUpEvent extends AuthEvent {
  final String data; // userToken

  InitGoogleSingleSignUpEvent(
      this.data,
      );

  @override
  List<Object> get props => null;
}

class GoogleLogginInEvent extends AuthEvent {
  final String data; // userToken

  GoogleLogginInEvent(
      this.data,
      );

  @override
  List<Object> get props => [data];
}