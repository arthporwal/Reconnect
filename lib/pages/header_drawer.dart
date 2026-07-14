import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reconnect/pages/Upload.dart';
import '../widgets/drawer_list.dart';
import 'about_us.dart';
import 'feedback.dart';
import 'my_account.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 58, 116, 98),
            Color.fromARGB(255, 36, 182, 121)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 40.0),
        child: Column(
          children: [
            headerWidget(),

            // black line in between
            const Divider(
              thickness: 2,
              height: 56,
              color: Color.fromARGB(255, 40, 34, 34),
            ),

            // this is the list of items in the drawer

            DrawerList(
              name: 'My Account',
              icon: Icons.account_box,
              onPressed: () => onItemPressed(context, index: 0),
            ),
            SizedBox(height: 24),

            DrawerList(
              name: 'Feedback & Support',
              icon: Icons.feedback,
              onPressed: () => onItemPressed(context, index: 1),
            ),
            SizedBox(height: 24),

            DrawerList(
              name: 'About Us',
              icon: Icons.details,
              onPressed: () => onItemPressed(context, index: 2),
            ),
            SizedBox(height: 24),

            DrawerList(
              name: 'Emotion Detector',
              icon: Icons.camera_alt_outlined,
              onPressed: () => onItemPressed(context, index: 4),
            ),
            SizedBox(height: 24),

            DrawerList(
                name: 'Log out',
                icon: Icons.logout,
                onPressed: () {
                  onItemPressed(context, index: 3);
                  Fluttertoast.showToast(msg: 'Logged Out');
                }),
            SizedBox(height: 24),

            // line at last

            const Divider(
              thickness: 2,
              height: 56,
              color: Color.fromARGB(255, 40, 34, 34),
            ),
          ],
        ),
      ),
    ));
  }

//navigating back and forth from home screen
  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAccount()));
        break;

      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => My_feedback()));
        break;

      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const About_us()));
        break;

      case 3:
        FirebaseAuth.instance.signOut();
        print('Logged Out');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => exit(1)));
        break;

      case 4:
        print('Working...');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Upload()));
        break;
    }
  }

// properties of the elements
  Widget headerWidget() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          // Text(
          //   'Person Name',
          //   style: TextStyle(color: Colors.purple, fontSize: 22),
          // ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome to Reconnect',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ])
      ],
    );
  }
}
