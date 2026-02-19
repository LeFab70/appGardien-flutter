import 'bottom.nav.widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SafeAreaWidget extends StatelessWidget {
  final Function(int) changedIndex;
  final int currentIndex;
  const SafeAreaWidget({super.key, required this.changedIndex, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Use Expanded to ensure icons take equal space without overflowing
            Expanded(
              child: BottomNavWidget(
                icon: Ionicons.home,
                onTap: () => changedIndex(0),
                color: Colors.white,
                activeColor: Colors.amberAccent,
                isActive: currentIndex == 0,
                label: 'Home',
              ),
            ),
            Expanded(
              child: BottomNavWidget(
                icon: Ionicons.search,
                onTap: () => changedIndex(1),
                color: Colors.white,
                activeColor: Colors.amberAccent,
                isActive: currentIndex == 1,
                label: 'Search',
              ),
            ),


            const SizedBox(width: 48), //
            Expanded(
              child: BottomNavWidget(
                icon: Ionicons.cart,
                onTap: () => changedIndex(2),
                color: Colors.white,
                activeColor: Colors.amberAccent,
                isActive: currentIndex == 2,
                label: 'Cart',
              ),
            ),
            Expanded(
              child: BottomNavWidget(
                icon: Ionicons.person,
                onTap: () => changedIndex(3),
                color: Colors.white,
                activeColor: Colors.amberAccent,
                isActive: currentIndex == 3,
                label: 'Profile',
              ),
            ),
          ],
        )
        ),
      );

  }
}