
import 'package:dartz/dartz.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class RegisterUserUseCase {
  final Repository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, SingleSignInDto>> call(
      SingleSignInDto data,
      ) {
    return repository.createUser(data);
  }
}