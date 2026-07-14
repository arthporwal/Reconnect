import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 58, 116, 98),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 50),
              Image.network(
                  'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
                  cacheHeight: 100,
                  cacheWidth: 100),
              SizedBox(height: 50),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "\n\nUser id:  888RECxxxxx121",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "\nEmail : arxxxx67@gmail.com\n",
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           // fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ]),
              // SizedBox(height: 20),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Phone no. : 97xxxxxx89",
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           // fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ]),
            ],
          ),
        ),
      ),
    );
  }
}
