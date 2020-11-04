import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class CheckIfUserPersistsUseCase {
  final Repository repository;

  CheckIfUserPersistsUseCase(this.repository);

  Future<bool> call(String userId) async {
    return repository.checkIsUserPresent(userId);
  }
}