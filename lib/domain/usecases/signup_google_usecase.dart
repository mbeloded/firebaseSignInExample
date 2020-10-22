
import 'package:dartz/dartz.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class SignUpGoogleUseCase {
  final Repository repository;

  SignUpGoogleUseCase(this.repository);

  Future<Either<Failure, SingleSignInDto>> call(
      String data,
      ) {
    return repository.googleSignIn(data);
  }
}