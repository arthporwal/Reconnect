import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class reset extends StatefulWidget {
  const reset({super.key});

  @override
  State<reset> createState() => _resetState();
}

class _resetState extends State<reset> {
  @override
  Widget build(BuildContext context) {
    // String _email;
    TextEditingController _email = TextEditingController();
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
        title: const Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: const InputDecoration(
                    hintText: "Enter Your Email ID",
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.black,
                    )),
                // onChanged: (value) {
                //   setState(() {
                //     _email = value;
                //   });
                // },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 36, 182, 121)),
                    child: Text('Send Mail'),
                    onPressed: () {
                      auth.sendPasswordResetEmail(email: _email.text.trim());
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return Container(
                      //         child: AlertDialog(
                      //           title: Text("Please check your Spam folder"),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: () => Navigator.pop(context),
                      //                 child: Text('Ok'))
                      //           ],
                      //         ),
                      //       );
                      //     });
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: 'Email Sent');
                    },
                  ),
                ],
              )
            ])),
      ),
    );
  }
}
