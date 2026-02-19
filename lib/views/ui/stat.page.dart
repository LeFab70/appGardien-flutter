import 'package:flutter/material.dart';
import 'package:test1_appgardienbut_fabrice/views/shared/styles/app.style.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Stat page', style: appStyle(40, Colors.black, .bold)),
      ),
    );
  }
}
