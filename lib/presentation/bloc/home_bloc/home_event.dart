
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitHomeEvent extends HomeEvent {

  InitHomeEvent();

  @override
  List<Object> get props => [];

}

class HomeLogoutEvent extends HomeEvent {

  HomeLogoutEvent();

  @override
  List<Object> get props => [];

}
