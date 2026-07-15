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
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        creator: doc['creator'] ?? '',
        text: doc['text'] ?? '',
        timestamp: doc['timestamp'] ?? 0,
      );
    }).toList();
  }

  Future savePost(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection("posts").add({
      'text': text,
      'creator': user.displayName?.trim().isNotEmpty == true
          ? user.displayName
          : user.email ?? user.uid,
      'creatorId': user.uid,
      'creatorEmail': user.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<PostModel>> getPostsByUser(creator) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('creator', isEqualTo: creator)
        .snapshots()
        .map(_postListFromSnapshot);
  }
}

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;

  PostModel(
      {required this.id,
      required this.creator,
      required this.text,
      required this.timestamp});
}
