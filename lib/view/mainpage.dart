import 'package:flutter/material.dart';
import 'package:final_mobile/model/user.dart';
import 'package:final_mobile/view/favouritePage.dart';
import 'package:final_mobile/view/profilePage.dart';
import 'package:final_mobile/view/subjectPage.dart';
import 'package:final_mobile/view/cartpage.dart';
import 'package:final_mobile/view/tutorPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = " Subjects";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      SubjectPage(user: widget.user),
      TutorPage(user: widget.user),
      cartPage(user: widget.user),
      const FavouritePage(),
      ProfilePage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logot.png',
              fit: BoxFit.contain,
              height: 60,
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
      ),

      body: tabchildren[_currentIndex], 

      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: Colors.blueGrey,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          SalomonBottomBarItem(
            selectedColor: Colors.redAccent,
            title: const Text("Subjects"),
            icon: const Icon(Icons.subject_outlined),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.lightBlue,
            title: const Text("Tutors"),
            icon: const Icon(Icons.school),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.deepPurple,
            title: const Text("Cart"),
            icon: const Icon(Icons.shopping_cart),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.amber,
            title: const Text("Favourite"),
            icon: const Icon(Icons.star),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.green,
            title: const Text("Profile"),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Subjects";
      }
      if (_currentIndex == 1) {
        maintitle = "Tutors";
      }
      if (_currentIndex == 2) {
        maintitle = "Cart";
      }
      if (_currentIndex == 3) {
        maintitle = "Favourite";
      }
      if (_currentIndex == 4) {
        maintitle = "Profille";
      }
    });
  }
}
