import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale_app/Pages/signInPage.dart';

import 'package:hyper_garage_sale_app/pages/homePage.dart';
import 'package:hyper_garage_sale_app/pages/newClassifiedPage.dart';
import 'package:hyper_garage_sale_app/pages/signUpPage.dart';
import 'package:hyper_garage_sale_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('you have an error: ${snapshot.error.toString()}');
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                return const AuthenticationWrapper();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        initialRoute: '/',
        routes: {
          '/newClassified': (context) => const NewClassifiedPage(),
          '/homePage': (context) => const HomePage(),
          '/signupPage': (context) => SignUpPage(),
          '/signinPage': (context) => SignInPage(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      print("User signed in with email: ${firebaseUser.email}");
      return const HomePage();
    } else {
      print("not signed in");
      return SignInPage();
    }
  }
}
