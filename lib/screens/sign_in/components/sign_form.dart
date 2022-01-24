import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:material_app/components/custom_surfix_icon.dart';
import 'package:material_app/components/form_error.dart';
import 'package:material_app/logic/loginCubit/login_cubit.dart';
import 'package:material_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return DefaultButton(
                text: "Continue",
                press: state.status.isValidated
                    ? () => context.read<LoginCubit>().onSubmitted()
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  BlocBuilder<LoginCubit, LoginState> buildPasswordFormField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onSaved: (newValue) => password = newValue,
          onChanged: (password) =>
              context.read<LoginCubit>().onPasswordChanged(password),
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }

  BlocBuilder<LoginCubit, LoginState> buildEmailFormField() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) => email = newValue,
          onChanged: (email) =>
              context.read<LoginCubit>().onEmailChanged(email),
              
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            errorText: state.email.invalid ? 'invalid email' : null,
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          ),
        );
      },
    );
  }
}
