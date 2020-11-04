
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/domain/usecases/get_current_user_usecase.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_state.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  AuthBloc authBloc;
  GetCurrentUserUseCase _getCurrentUserUseCase;

  HomeBloc(this.authBloc, this._getCurrentUserUseCase);

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {
    if (event is InitHomeEvent) {
      //get current user and get info about it
      var user = await _getCurrentUserUseCase();

      user.fold((error) => (){
        authBloc.add(LogoutEvent());
      }, (data) => (){
        return InitedHomeState(data);
      });

    }
    else if (event is HomeLogoutEvent) {
      authBloc.add(LogoutEvent());
    }
  }

}
