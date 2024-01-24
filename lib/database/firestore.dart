import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*

This database stores posts that users have published in the app.
It is stored in a collection called 'Posts' in firesbase.

Each post contains;
- A message
- email of user
- timestamp

 */


class FirestoreDatabase{
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of post from firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message){
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'Timestamp': Timestamp.now(),
    });
  }

  // read post from firebase
  Stream<QuerySnapshot> getPostsStream(){
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('Timestamp', descending: true).snapshots();

    return postsStream;
  }
}