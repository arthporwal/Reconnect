import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/widgets/Google.dart';
import 'forgot_password.dart';
import 'quizpage.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key}) : super(key: key);

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  bool hide = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPasword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found");
        Fluttertoast.showToast(msg: 'User not Found');
      }
    }
    return user;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 60),
            Text(
              "Reconnect",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Login ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter your Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  )),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: hide,
              decoration: InputDecoration(
                  hintText: "Enter your Password",
                  prefixIcon: Icon(
                    Icons.security,
                    color: Colors.black,
                  ),
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => reset()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            // SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Color.fromARGB(255, 36, 182, 121),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () async {
                  User? user = await loginUsingEmailPasword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', _emailController.text);
                    sharedPreferences.setString('uid', user.uid);
                    Fluttertoast.showToast(msg: 'Logged in');
                    print('Login Successful');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => const Home())));
                  } else {
                    Fluttertoast.showToast(msg: 'Incorrect Email or Password');
                    print('Invalid Credentials');
                  }
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            signUpOption(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor:
                            const Color.fromARGB(255, 36, 182, 121),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(40),
                      ),
                      icon: FaIcon(FontAwesomeIcons.google),
                      label: Text('Sign up with Google'),
                      onPressed: () async {
                        var provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        try {
                          final userCredential = await provider.googleLogin();
                          final user = userCredential?.user;
                          if (user == null) return;

                          final sharedPreferences =
                              await SharedPreferences.getInstance();
                          await sharedPreferences.setString('uid', user.uid);
                          if (user.email != null) {
                            await sharedPreferences.setString(
                                'email', user.email!);
                          }

                          Fluttertoast.showToast(msg: 'Logged in');
                          final nextScreen =
                              userCredential!.additionalUserInfo?.isNewUser ==
                                      true
                                  ? const QuizPage()
                                  : const Home();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => nextScreen));
                        } on FirebaseAuthException catch (error) {
                          Fluttertoast.showToast(
                              msg: error.message ?? 'Google sign in failed');
                        } catch (error) {
                          Fluttertoast.showToast(
                              msg:
                                  'Google sign in failed. Check Firebase Google sign-in setup.');
                          print('Google sign in failed: $error');
                        }
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.black)),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  void _togglePasswordView() {
    setState(() {
      hide = !hide;
    });
  }
}
