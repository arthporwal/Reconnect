import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/widgets/Google.dart';
import 'forgot_password.dart';
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
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: const Color.fromARGB(255, 36, 182, 121),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(340, 40),
                    ),
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Sign up with Google'),
                    onPressed: () {
                      var provider = Provider.of<GoogleSignInProvider>(context,
                          listen: false);
                      provider.googleLogin();
                    })
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
