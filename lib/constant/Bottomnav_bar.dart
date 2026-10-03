import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            spreadRadius: 1,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 98,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),

              _navItem(
                icon: Icons.search,
                activeIcon: Icons.search,
                label: 'Search',
                index: 1,
              ),

              _navItem(
                icon: Icons.bookmark_border,
                activeIcon: Icons.bookmark_border,
                label: 'Saved',
                index: 2,
              ),

              _navItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person_outline,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({required IconData icon, required IconData activeIcon, required String label, required int index,}) {
    final bool isSelected = currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(isSelected ? activeIcon : icon, size: 25, color: isSelected ? const Color(0xFF263238) : const Color(0xFF90A0A3),),
            const SizedBox(height: 6),
            // Label
            Text(label, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? const Color(0xFF263238) : const Color(0xFF90A0A3),),),
            const SizedBox(height: 6),
            // Selected indicator dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 5 : 0,
              height: isSelected ? 5 : 0,
              decoration: const BoxDecoration(
                color: Color(0xFF263238),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}