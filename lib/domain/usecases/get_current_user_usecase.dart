import 'package:dartz/dartz.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class GetCurrentUserUseCase {
  final Repository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>>call() async {
    return repository.getCurrentUser();
  }
}