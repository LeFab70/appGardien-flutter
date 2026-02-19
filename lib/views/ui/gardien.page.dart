import 'package:flutter/material.dart';

import '../shared/styles/app.style.dart';

class GardienPage extends StatefulWidget {
  const GardienPage({super.key});

  @override
  State<GardienPage> createState() => _GardienPageState();
}

class _GardienPageState extends State<GardienPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Gardien page', style: appStyle(40, Colors.black, .bold)),
      ),
    );
  }
}
