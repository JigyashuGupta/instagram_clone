import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async{
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnapshot(snapshot);
  }
  //sign up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
}) async {
    String res = "Some error occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty && file!=null){
      //  register user
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          bio: bio,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          uid: userCredential.user!.uid,
          username: username,
        );
        await _firestore.collection('users').doc(userCredential.user!.uid).set(user.toJson(),);
        // add user to database
        res = 'Success!';
      }
      else{
        res = 'One of the fields is empty!';
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
  //log in
  Future<String> loginUser({required String email, required String password})async {
    String res = 'Some error occured';
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'Success!';
      }
      else{
        res = 'One of the fields is empty!';
      }
    }
    catch(e){
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }

}