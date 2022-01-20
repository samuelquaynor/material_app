import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_app/constants.dart';
import 'package:material_app/data/repositories/authentication_repository.dart';
import 'package:material_app/data/repositories/user_repository.dart';
import 'package:material_app/logic/bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:material_app/routes.dart';
import 'package:material_app/screens/splash/splash_screen.dart';
import 'package:material_app/theme.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..indicatorColor = kPrimaryColor
    ..backgroundColor = Colors.white
    ..textColor = kSecondaryColor
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 55, vertical: 45)
    ..radius = 10.0
    ..textStyle = GoogleFonts.poppins(
      color: kPrimaryColor,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    )
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: theme(),
          initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
