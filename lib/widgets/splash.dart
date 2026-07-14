import 'package:flutter/material.dart';
import 'package:reconnect/pages/Login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    //
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Center(child: LoginScreens())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Image(
    image: AssetImage('assets/Reconnect.jpg'),
  )));
  }
}

// Future Verification() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   var email = sharedPreferences.getString('email');
//   runApp(MaterialApp(
//     home: email == null ? LoginScreens() : Home(),
//   ));
// }
