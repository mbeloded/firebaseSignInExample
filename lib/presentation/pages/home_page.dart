
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/injection_container.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_state.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';
import 'package:single_sign_in_firestore/presentation/widgets/primary_button_solid.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  // final UserEntity authorizedUser;

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  HomeBloc _bloc;

  static const String _channel = 'single_sign_in_activity';
  static const _platform = const MethodChannel(_channel);

  @override
  void initState() {
    super.initState();
    _bloc = getIt<HomeBloc>();

    _bloc.add(InitHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: _bloc,
        listener: (context, state) {
          print('Base bloc state - ${state.runtimeType.toString()}');

        },
        builder: (context, state) {
          if (state is InitedHomeState) {
            return _buildMain(state.data);
          }
          print("build empty");
          return _buildEmpty();
        });
  }

  Widget _buildMain(UserEntity data) {
    return Container(
      child: Column(

        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text("User name: ${data.name}"),
          SizedBox(
            height: 10.0,
          ),
          Text("User email: ${data.email}"),
          SizedBox(
            height: 60.0,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: PrimarySmall("Sign out", (){
                _bloc.add(HomeLogoutEvent());
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(
            height: 60.0,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: PrimarySmall("Sign out", (){
                _bloc.add(HomeLogoutEvent());
              }),
            ),
          ),
        ],
      ),
    );
  }
}