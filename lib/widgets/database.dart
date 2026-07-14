import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String uid;

  Database({required this.uid});

  final userCollection = FirebaseFirestore.instance.collection("Users");

  Future updateUserinfo(String Name, int Phone) async {
    return await userCollection.doc(uid).set({
      'displayName': Name,
      'Phone': Phone,
    });
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  Future getCurrentUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String Name = ds.get('displayName');
      String Phone = ds.get('Phone');
      return [Name, Phone];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
