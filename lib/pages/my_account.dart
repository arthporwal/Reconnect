import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Future<Map<String, dynamic>?> _loadUserProfile(User user) async {
    final users = FirebaseFirestore.instance.collection('Users');
    final directDoc = await users.doc(user.uid).get();
    if (directDoc.exists) {
      return directDoc.data();
    }

    final query = await users.where('uid', isEqualTo: user.uid).limit(1).get();
    if (query.docs.isEmpty) return null;
    return query.docs.first.data();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
      ),
      body: SafeArea(
        child: user == null
            ? const Center(child: Text('No user is currently signed in.'))
            : FutureBuilder<Map<String, dynamic>?>(
                future: _loadUserProfile(user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final profile = snapshot.data ?? {};
                  final displayName =
                      profile['displayName']?.toString().trim().isNotEmpty ==
                              true
                          ? profile['displayName'].toString()
                          : user.displayName ?? 'Reconnect User';
                  final email = profile['email']?.toString() ?? user.email;
                  final phone = profile['Phone']?.toString();
                  final age = profile['age']?.toString();

                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const SizedBox(height: 30),
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: const Color.fromARGB(255, 58, 116, 98),
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : null,
                        child: user.photoURL == null
                            ? const Icon(Icons.person,
                                color: Colors.white, size: 56)
                            : null,
                      ),
                      const SizedBox(height: 28),
                      _InfoTile(label: 'Name', value: displayName),
                      _InfoTile(label: 'User ID', value: user.uid),
                      if (email != null)
                        _InfoTile(label: 'Email', value: email),
                      if (phone != null)
                        _InfoTile(label: 'Phone', value: phone),
                      if (age != null) _InfoTile(label: 'Age', value: age),
                    ],
                  );
                },
              ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        tileColor: const Color.fromARGB(24, 58, 116, 98),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
