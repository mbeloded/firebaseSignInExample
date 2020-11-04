
import 'package:equatable/equatable.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialHomeState extends HomeState {
  InitialHomeState();

  @override
  List<Object> get props => [];
}

class InitedHomeState extends HomeState {

  final UserEntity data;

  InitedHomeState(this.data);

  @override
  List<Object> get props => [data];
}