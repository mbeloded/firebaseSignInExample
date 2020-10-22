
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_sign_in_firestore/common/utils.dart';
import 'package:single_sign_in_firestore/injection_container.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:single_sign_in_firestore/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:single_sign_in_firestore/presentation/widgets/sign_in_button.dart';

class LoginPage extends StatefulWidget {

  static const routeName = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthBloc _bloc;

  _LoginPageState() {
    _bloc = getIt<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child:
        BlocConsumer<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            // do stuff here based on BlocA's state
            if (state is ErrorGoogleLoginState) {
                print("show an error here");
            } else if (state is GoogleLogginInState) {
              _bloc.add(GoogleLogginInEvent(state.data));
            } else if (state is ErrorUserNotFoundState) {
              //show an alert here about do you want to register a new user ?
              Utils.showRegistrationDialog(context, (){
                _bloc.add(InitGoogleSingleSignUpEvent(state.data));
              });
            }
          },
          builder: (BuildContext context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(size: 150),
                  SizedBox(height: 50),
                  SignInButton(title: "Sign in with Google",
                      clickCallback: () {
                        print("clicked on Sign In btn");
                        _bloc.add(InitGoogleSingleSignIn());
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}