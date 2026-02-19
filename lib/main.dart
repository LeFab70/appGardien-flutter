import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/main.screen.provider.dart';
import 'root/app.gardienbut.entry.dart';

void main() => runApp(
  //Mise en place du provider pour gerer le changement de pages depuis le bottomNavigationBar
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ],
    child: const AppGardienbutEntry(),
  ),
);
