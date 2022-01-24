import 'package:flutter/material.dart';
import 'package:material_app/data/repositories/authentication_repository.dart';
import 'package:material_app/logic/bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:material_app/logic/loginCubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_app/models/wrappers/auth_status.dart';
import 'package:material_app/screens/home/home_screen.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authStatus.status == AuthenticationStatus.authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Sign In"),
          ),
          body: const Body(),
        ),
      ),
    );
  }
}
