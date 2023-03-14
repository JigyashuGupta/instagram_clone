import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Widgets/post_card.dart';
import 'package:instagram_clone/pages/add_post_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

import '../utils/utils.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final navigator = Navigator.of(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  print("File");
                  navigator.push(MaterialPageRoute(builder: (context) => AddPostScreen(file: file)));
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final navigator = Navigator.of(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  navigator.push(MaterialPageRoute(builder: (context) => AddPostScreen(file: file)));
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: width > webScreenSize
            ? null
            : AppBar(
                backgroundColor: mobileBackgroundColor,
                centerTitle: false,
                title: SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 32,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      _selectImage(context);
                    //  const AddPostScreen(),
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  Container( margin: EdgeInsets.symmetric(horizontal: width > webScreenSize? width*0.3 : 0, vertical: width > webScreenSize? 15 : 0),
                      child: PostCard(snap: snapshot.data!.docs[index].data())),
            );
          },
        ));
  }
}
