import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/login.provider.dart';
import 'controllers/main.screen.provider.dart';
import 'root/app.gardienbut.entry.dart';

void main() => runApp(
  //Mise en place du provider pour gerer le changement de pages depuis le bottomNavigationBar
  MultiProvider(
    providers: [
      //provider pour changer de pages a afficher
      ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
      // Provider pour la connexion
      ChangeNotifierProvider(create: (context) => LoginProvider()),
    ],
    child: const AppGardienbutEntry(),
  ),
);
