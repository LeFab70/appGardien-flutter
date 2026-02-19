import 'package:flutter/material.dart';
import '../views/ui/main.screen.dart';
import '../views/shared/colors/colors.app.dart';

class AppGardienbutEntry extends StatelessWidget {
  const AppGardienbutEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.buttonBackground,
          iconSize: 35,
          elevation: 4,
          foregroundColor: AppColors.buttonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
        bottomAppBarTheme: BottomAppBarThemeData(
          shape: const CircularNotchedRectangle(),
          color: AppColors.bottomNavColors,
        ),
      ),

      home: MainScreen(),
    );
  }
}
