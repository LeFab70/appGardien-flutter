import 'package:flutter/material.dart';

import '../shared/styles/app.style.dart';

class EquipePage extends StatefulWidget {
  const EquipePage({super.key});

  @override
  State<EquipePage> createState() => _EquipePageState();
}

class _EquipePageState extends State<EquipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Equipe page', style: appStyle(40, Colors.black, .bold)),
      ),
    );
  }
}
