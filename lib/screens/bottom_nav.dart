import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:takecare/screens/articles_screen.dart';
import 'package:takecare/screens/chat_screen.dart';
import 'package:takecare/screens/home_screen.dart';
import 'package:takecare/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentTabIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homeScreen;
  late ChatScreen chatScreen;
  late ArticlesScreen articlesScreen;
  late ProfileScreen profileScreen;

  @override
  void initState() {
    homeScreen = const HomeScreen();
    chatScreen = const ChatScreen();
    articlesScreen = const ArticlesScreen();
    profileScreen = const ProfileScreen();

    pages = [homeScreen,chatScreen,articlesScreen,profileScreen];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Durations.medium2,
        onTap: (index){
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.article_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_2_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}