import 'package:flutter/material.dart';
import 'package:test1_appgardienbut_fabrice/views/shared/colors/colors.app.dart';
import '../shared/styles/app.style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variable locale temporaire pour le switch (avant d'utiliser un Provider)
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paramètres',
            style: appStyle(24, AppColors.textColor, FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Section Réglages
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
                color: AppColors.buttonBackground , // Couleur assortie à ton thème
              ),
              title: Text(
                  'Mode Sombre',
                  style: appStyle(18, AppColors.textColor, FontWeight.w500)
              ),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  // ThemeProvider plus tard
                },
              ),
            ),
          ),

          const Spacer(), // Pousse le contenu suivant vers le bas

          // Section Infos / Crédits
          Center(
            child: Column(
              children: [
                Text(
                  "Author: Fabrice Kouonang",
                  style: appStyle(16, AppColors.textColor, FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Version 1.0.0 • CCNB-2026",
                  textAlign: TextAlign.center,
                  style: appStyle(12, Colors.grey, FontWeight.normal),
                ),
                const SizedBox(height: 30), // Petit espace de sécurité en bas
              ],
            ),
          ),
        ],
      ),
    );
  }
}