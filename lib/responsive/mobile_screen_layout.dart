import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();

  }
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState((){
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
    physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      backgroundColor: mobileBackgroundColor,
      bottomNavigationBar: CupertinoTabBar(
        activeColor: primaryColor,
        inactiveColor: secondaryColor,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '', backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
