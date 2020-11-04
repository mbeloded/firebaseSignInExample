import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/data/datasources/local_data_source.dart';
import 'package:single_sign_in_firestore/presentation/bloc/nav_bloc/nav_event.dart';
import 'package:single_sign_in_firestore/presentation/pages/home_page.dart';
import 'package:single_sign_in_firestore/presentation/pages/login_page.dart';

class NavBloc extends Bloc<NavEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final LocalDataSource localDataSource;

  NavBloc(this.localDataSource);

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavEvent event) async* {
    if (event is NavPopCurrentScreen) {
      navigatorKey.currentState.pop();
    } else if (event is NavLogin) {

        navigatorKey.currentState
            .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => route.isFirst);

    } else if (event is NavHome) {
      navigatorKey.currentState
          .pushNamed(HomePage.routeName, arguments: event.args);
    }
  }

  /// Nav bloc state handler
  /// Example of args: args(settings.arguments as List<Object>).first)
  MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    print('build route for ${settings.name}');
    print('args  ${settings.arguments}');

    var routes = <String, WidgetBuilder>{
      LoginPage.routeName: (context) => LoginPage(),
      HomePage.routeName: (context) => HomePage(),
    };

    WidgetBuilder builder = routes[settings.name];
    return MaterialPageRoute(settings: settings, builder: (ctx) => builder(ctx));
  }
}
