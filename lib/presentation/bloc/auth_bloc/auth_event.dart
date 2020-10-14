
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

class GoogleLoginEvent extends AuthEvent {
  final String data; // userToken

  GoogleLoginEvent(
      this.data,
      );

  @override
  List<Object> get props => [data];
}