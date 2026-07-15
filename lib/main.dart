import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/widgets/Google.dart';
import 'pages/home.dart';
import 'pages/Login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Reconnect',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 43, 165, 139),
              ),
            ),
            home: AnimatedSplashScreen(
              //takes the 1st screen to be displayed, adding splash here
              backgroundColor: const Color.fromARGB(255, 2, 2, 2),
              splash: Center(
                child: Container(
                  child: Image(
                    image: AssetImage('assets/Reconnect.jpg'),
                  ),
                ),
              ),
              splashTransition: SplashTransition.scaleTransition,

              nextScreen: const AuthGate(),
            )),
      );
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data != null) {
          return const Home();
        }

        return const LoginScreens();
      },
    );
  }
}
