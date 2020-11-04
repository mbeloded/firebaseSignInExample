import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;
  final String message;
  final String _suffix;

  Failure([this.code, this.message, this._suffix]);
}

class BaseFailure extends Failure {
  final int code;
  final String message;
  final String suffix;

  BaseFailure([this.code, this.message, this.suffix])
      : super(code, message, suffix);

  @override
  List<Object> get props => [code];

  String toString() {
    return "$code $message $suffix";
  }
}

class CacheFailure extends BaseFailure {}

class UserNotCreatedFailure extends BaseFailure {

  final String message;

  UserNotCreatedFailure(this.message)
      : super(405, message);
}

class FireStoreFailure extends BaseFailure {

  final dynamic data;
  final String message;

  FireStoreFailure(this.data, this.message)
      : super(1000, message);

}