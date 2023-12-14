import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_jc_2023/firebase_options.dart';
import 'package:login_jc_2023/providers/selected_value_notifier.dart';
import 'package:login_jc_2023/providers/superheros_providers.dart';
import 'package:login_jc_2023/screens/login/auth_page.dart';
import 'package:login_jc_2023/screens/login/verify_email_page.dart';
import 'package:login_jc_2023/screens/screens.dart';
import 'package:login_jc_2023/utils/utils.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppState());
}

final navigatorKey = GlobalKey<NavigatorState>();

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SuperherosProvider(name),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SelectedValueNotifier(),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Characters',
        theme: ThemeData.dark().copyWith(),
        initialRoute: 'main',  // Cambiado de 'home' a 'main'
        routes: {
          'main': (_) => MainPage(),
          'home': (_) => HomeScreen(),
          'details': (_) => DetailsScreen(),
          'favorites': (_) => MyScrollableCards(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const VerifyEmailPage();
            } else {
              return const AuthPage();
            }
          },
        ),
      );
}
