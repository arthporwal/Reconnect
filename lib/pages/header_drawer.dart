import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reconnect/pages/Login.dart';
import 'package:reconnect/widgets/Google.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(15.0, 24.0, 15.0, 24.0),
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
  Future<void> onItemPressed(BuildContext context, {required int index}) async {
    final navigator = Navigator.of(context);
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);
    navigator.pop();
    switch (index) {
      case 0:
        navigator.push(MaterialPageRoute(builder: (context) => MyAccount()));
        break;

      case 1:
        navigator.push(MaterialPageRoute(builder: (context) => My_feedback()));
        break;

      case 2:
        navigator
            .push(MaterialPageRoute(builder: (context) => const About_us()));
        break;

      case 3:
        await FirebaseAuth.instance.signOut();
        await googleProvider.logout();
        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.remove('uid');
        await sharedPreferences.remove('email');
        print('Logged Out');
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreens()),
            (route) => false);
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
