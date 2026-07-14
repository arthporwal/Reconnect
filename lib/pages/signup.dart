import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reconnect/pages/quizpage.dart';
import 'package:reconnect/widgets/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _phonenumberTextEditingController =
      TextEditingController();
  TextEditingController _usernameEditingController = TextEditingController();
  TextEditingController _ageEditingController = TextEditingController();

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
        toolbarHeight: 65,
        title: const Text("RECONNECT"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            children: [
              const Text(
                "Welcome To Reconnect, \nLet's get started!",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 9, 9, 9)),
              ),
              const SizedBox(
                height: 100,
              ),
              TextField(
                controller: _usernameEditingController,
                decoration: const InputDecoration(
                    hintText: "Enter User Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    )),
              ),
              TextField(
                controller: _phonenumberTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Enter your phone number",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    )),
              ),
              TextField(
                controller: _ageEditingController,
                decoration: const InputDecoration(
                    hintText: "Enter your age",
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Colors.black,
                    )),
              ),
              TextField(
                controller: _emailTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Enter your Email",
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    )),
              ),
              TextField(
                controller: _passwordTextEditingController,
                decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.black,
                    )),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              firebaseUIButton(context, "Sign Up", () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextEditingController.text,
                        password: _passwordTextEditingController.text)
                    .then((value) {
                  User? updateUser = FirebaseAuth.instance.currentUser;
                  // ignore: deprecated_member_use
                  updateUser!.updateProfile(
                      displayName: _usernameEditingController.text);
                  userSetup(
                      int.parse(_phonenumberTextEditingController.text),
                      _usernameEditingController.text,
                      _emailTextEditingController.text,
                      int.parse(_ageEditingController.text));
                  print("Created New Account");
                  Fluttertoast.showToast(msg: 'Account Created');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(),
                      ));
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(msg: 'Account already exist');
                  print("Error ${error.toString()}");
                });
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 36, 182, 121)),
                  child: const Text("Already have an account?")),
            ],
          ),
        ),
      ),
    );
  }

  Container firebaseUIButton(
      BuildContext context, String title, Function onTap) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.white;
              }
              return Color.fromARGB(255, 36, 182, 121);
            }),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
      ),
    );
  }
}
