import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(
    int Phone, String displayName, String email, int age) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  await users.doc(uid).set({
    'displayName': displayName,
    'uid': uid,
    'Phone': Phone,
    'email': email,
    'age': age
  });
  return;
}

Future<void> RatingGiven(double Rating) async {
  CollectionReference Star = FirebaseFirestore.instance.collection('Rating');
  FirebaseAuth auth = FirebaseAuth.instance;
  String displayName = auth.currentUser!.displayName.toString();
  Star.add({'Rating': Rating, 'displayName': displayName});
  return;
}

Future<void> Analysis(int yes, int no) async {
  CollectionReference Analysis =
      FirebaseFirestore.instance.collection('Analysis');
  FirebaseAuth auth = FirebaseAuth.instance;
  String displayName = auth.currentUser!.displayName.toString();
  Analysis.add({'displayName': displayName, 'Yes': yes, 'No': no});
  return;
}

class Anal {
  final String Happy;
  final String Sad;
  Anal(this.Happy, this.Sad);

  Anal.fromMap(Map<String, dynamic> map)
      : assert(map['Yes'] != null),
        assert(map['No'] != null),
        Happy = map['No'],
        Sad = map['Yes'];

  @override
  String toString() => "Record<$Happy:$Sad>";
}

class PostService {
  Future savePost(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> commentsForPost(String postId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> saveComment(String postId, String text) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
