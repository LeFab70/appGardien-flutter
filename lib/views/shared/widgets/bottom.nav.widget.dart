import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final Color activeColor;
  final Color color;
  final String label;
  final bool isActive;

  const BottomNavWidget({
    super.key,
    this.onTap,
    required this.icon,
    required this.activeColor,
    required this.label,
    this.isActive = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // return InkWell(
    //   //return GestureDetector(
    //   onTap: onTap,
    //   splashColor: Colors.transparent,
    //   highlightColor: Colors.transparent,
    //   borderRadius: BorderRadius.circular(12),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Icon(icon, color: isActive ? activeColor : color, size: 28),
    //       const SizedBox(height: 4),
    //       Text(
    //         label,
    //         style: TextStyle(
    //           color: isActive ? activeColor : color,
    //           fontSize: 12,
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // Inside BottomNavWidget build method
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 60,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: .center,
            children: [
              Icon(icon, color: isActive ? activeColor : color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? activeColor : color,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
