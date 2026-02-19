import 'package:flutter/material.dart';

//Cette classe permet de gerer le changement de pages dans le bottomNavigation Bar
//Je vais m'en servir avec le provider en modifier la classe main de lancement de l'applicationn
class MainScreenNotifier extends ChangeNotifier{
  int _pageIndex=0;
  int get pageIndex=>_pageIndex;
  set pageIndex(int newIndex){
    _pageIndex=newIndex;
    notifyListeners();
  }
}