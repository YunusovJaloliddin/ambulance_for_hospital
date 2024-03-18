import 'package:ambulance_for_hospital/common/controller/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../features/auth/home/home_screen.dart';
import '../../features/auth/sign_in/sign_in.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../blocs/sign_in/sign_in_bloc.dart';
import '../blocs/sign_up/sign_up_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoreProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true),
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.status == AuthenticationStatus.unauthenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => SignInBloc()),
                      BlocProvider(create: (context) => SignUpBloc()),
                    ],
                    child: const SignIn(),
                  );
                } else {
                  return const HomeScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
