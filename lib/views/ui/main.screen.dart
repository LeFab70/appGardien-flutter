import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/widgets/app.bar.dart';
import '../shared/widgets/floating.buttons.dart';

import '../../controllers/main.screen.provider.dart';
import '../shared/widgets/safe.area.widget.dart';
import 'profile.page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  //Liste des pages à utiliser dans le bottomnavigationBar
  final List<Widget> pageList = [
    // HomePage(),
    // SearchPage(),
    // HomePage(),
    // CartPage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;
    //Utilisation du provider pour fournir les pages de la bottomnavigation bar
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          appBar: AppBars(onPressed: (){},),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: pageList[mainScreenNotifier.pageIndex],
          //Changer les pages suivants le click/onTap
          bottomNavigationBar: BottomAppBar(
            notchMargin: 6.0,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias, // Ensures the notch looks smooth
            child: SafeAreaWidget(
              currentIndex: mainScreenNotifier.pageIndex,
              changedIndex: (index) => mainScreenNotifier.pageIndex = index,
            ),
          ),
          floatingActionButton: FloatingButtons(onPressed: () {}),
        );
      },
    );
  }
}
