import 'package:airbnb/view/home/explore_screen.dart';
import 'package:airbnb/view/message/message_screen.dart';
import 'package:airbnb/view/profile/profile_screen.dart';
import 'package:airbnb/view/trip/trip_screen.dart';
import 'package:airbnb/view/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectIndex = 0;
  late List<Widget> pages = [];
  @override
  void initState() {
    pages = [
      const ExploreScreen(),
      const WishlistScreen(),
      const TripScreen(),
      const MessageScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        iconSize: 32,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black45,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "asset/images/trip.png",
              scale: 18,
              color: selectIndex == 2 ? Colors.pinkAccent : Colors.black45,
            ),
            label: "Trip",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: "Profile",
          ),
        ],
      ),
      body: pages[selectIndex],
    );
  }
}
