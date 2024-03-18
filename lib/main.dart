import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/blocs/authentication/authentication_bloc.dart';
import 'common/repository/home_repository.dart';
import 'common/services/notification_service.dart';
import 'common/widget/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  NotificationService()
    ..requestPermisson()
    ..generateToken()
    ..notificationSettings();

  runApp(
    App(homeRepository: HomeRepository()),
  );
}

class App extends StatelessWidget {
  final IHomeRepository homeRepository;

  const App({super.key, required this.homeRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(myHomeRepository: homeRepository),
        ),
      ],
      child: const MyApp(),
    );
  }
}
