import 'package:flutter/material.dart';
import 'package:task/screens/HomePage.dart';

import '../constant/Bottomnav_bar.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    Homepage(),
    // Replace these with your actual screens
    const Center(child: Text('Search'),),
    const Center(child: Text('Saved'),),
    const Center(child: Text('Profile'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: currentIndex, children: pages,),

      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}