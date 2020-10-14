
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/injection_container.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/home_bloc/home_state.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  final UserEntity authorizedUser;

  const HomePage({Key key, this.authorizedUser}) : super(key: key);

  @override
  FlutterComponent createState() => new FlutterComponent();
}

class FlutterComponent extends State<HomePage> with WidgetsBindingObserver {

  HomeBloc bloc;
  NavBloc navBloc;

  static const String _channel = 'single_sign_in_activity';
  static const _platform = const MethodChannel(_channel);

  @override
  void initState() {
    navBloc = getIt<NavBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) {
          print('Base bloc state - ${state.runtimeType.toString()}');

        },
        builder: (context, state) {

          print("build main");
          return _buildMain();
        });
  }

  Widget _buildMain() {
    return Container();
  }
}