import 'package:cloud_firestore/cloud_firestore.dart';
class User {
  final String email;
  final String uid;
  final String username;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;
  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });
  static User fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      email: snapshot['email'],
      bio: snapshot['bio'],
    );

  }
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };
}
