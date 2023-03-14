import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_screen.dart';
import 'package:instagram_clone/pages/feed_screen.dart';
import 'package:instagram_clone/pages/profile_screen.dart';

import '../pages/search_screen.dart';

const webScreenSize = 600;

List<Widget>homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const Text('Coming soon'),
  const Text('notif'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
