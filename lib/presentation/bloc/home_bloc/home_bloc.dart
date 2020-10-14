
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_state.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  NavBloc navBloc;
  HomeBloc();

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {

  }

}
