import 'package:test1_appgardienbut_fabrice/views/shared/colors/colors.app.dart';

import '../shared/styles/app.style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres', style: appStyle(20, Colors.black, FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: Text('Mode Sombre', style: appStyle(18, Colors.black, FontWeight.w500)),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  hoverColor: AppColors.textColor,
                ),
              ),
            ),
            const SizedBox(height: 60,),
            Expanded(
              child: Column(
                children: [
                  Text("Author: Fabrice Kouonang",style: appStyle(20, AppColors.textColor, FontWeight.bold)),
                  Text("Version 1.0.0\nCCNB-2026", style: appStyle(14, Colors.grey, FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
