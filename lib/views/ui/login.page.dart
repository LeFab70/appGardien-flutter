import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1_appgardienbut_fabrice/views/shared/styles/app.style.dart';
import '../../controllers/login.provider.dart';
import '../shared/colors/colors.app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.backgroundApp,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("⚽", style: TextStyle(fontSize: 80)),
              const SizedBox(height: 20),
              Text(
                "GOALKEEPER APP",
                style: appStyle(24, AppColors.textColor, .bold),
              ),
              const SizedBox(height: 40),
              // Bouton pour se connecter
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                onPressed: () {
                  // On déclenche la connexion
                  Provider.of<LoginProvider>(context, listen: false).login();
                },
                child: Text(
                  "ENTRER DANS L'APP",
                  style: TextStyle(color: AppColors.buttonTextColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}