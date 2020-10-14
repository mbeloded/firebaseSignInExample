
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:single_sign_in_firestore/domain/entities/error_dto.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const [0]]);
}

class InitialSignInState extends AuthState {
  @override
  List<Object> get props => null;
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => null;
}

class GoogleRegisteredState extends AuthState {
  final UserEntity data;
  GoogleRegisteredState(this.data);

  @override
  List<Object> get props => null;
}

class GoogleLogInState extends AuthState {
  final String data; //tokenId
  GoogleLogInState(this.data);

  @override
  List<Object> get props => null;
}

class ErrorGoogleLoginState extends AuthState {
  final ErrorEntity data;
  ErrorGoogleLoginState(this.data);

  @override
  List<Object> get props => null;
}