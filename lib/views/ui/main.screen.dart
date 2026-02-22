import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1_appgardienbut_fabrice/views/ui/equipe.page.dart';
import 'package:test1_appgardienbut_fabrice/views/ui/gardien.page.dart';
import 'package:test1_appgardienbut_fabrice/views/ui/stat.page.dart';
import '../../controllers/teams.provider.dart';
import '../../models/game.dart';
import '../../models/goalkeeper.game.stat.dart';
import '../shared/colors/colors.app.dart';
import '../shared/styles/app.style.dart';
import '../shared/widgets/app.bar.dart';
import '../shared/widgets/floating.buttons.dart';

import '../../controllers/main.screen.provider.dart';
import '../shared/widgets/safe.area.widget.dart';
import 'profile.page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  //Liste des pages à utiliser dans le bottomnavigationBar
  final List<Widget> pageList = [
    StatPage(),
    EquipePage(),
    GardienPage(),
    ProfilePage(),
  ];


  // Ajout d'un match // fonction passée au floating button
  void _showScheduleGameModal(BuildContext context) {
    final provider = Provider.of<TeamsProvider>(context, listen: false);
    final _gameFormKey = GlobalKey<FormState>();

    String? hTeamId, vTeamId;
    String _location = "Stade Municipal";

    // Variables pour la date et l'heure
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    //Ajout d'une match/programmé
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder( // Nécessaire pour mettre à jour l'affichage de la date/heure dans la modale
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _gameFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Programmer un Match",
                    style: appStyle(20, AppColors.textColor, FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  // Lieu du match
                  TextFormField(
                    initialValue: _location,
                    decoration: const InputDecoration(
                      labelText: "Lieu du match",
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (val) => val == null || val.isEmpty ? "Lieu requis" : null,
                    onSaved: (val) => _location = val!,
                  ),

                  const SizedBox(height: 10),

                  // SELECTION DATE ET HEURE
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                          subtitle: const Text("Date"),
                          leading: const Icon(Icons.calendar_today),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setModalState(() => selectedDate = picked);
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(selectedTime.format(context)),
                          subtitle: const Text("Heure"),
                          leading: const Icon(Icons.access_time),
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null) setModalState(() => selectedTime = picked);
                          },
                        ),
                      ),
                    ],
                  ),

                  // Dropdown Domicile
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Équipe Domicile"),
                    value: hTeamId,
                    items: provider.teams
                        .map((t) => DropdownMenuItem(value: t.id, child: Text(t.name)))
                        .toList(),
                    onChanged: (v) => setModalState(() => hTeamId = v),
                    validator: (v) => v == null ? "Sélectionnez une équipe" : null,
                  ),

                  // Dropdown Visiteur (Filtre l'équipe domicile)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Équipe Visiteur"),
                    value: vTeamId,
                    // LOGIQUE : On retire l'équipe déjà choisie en Home
                    items: provider.teams
                        .where((t) => t.id != hTeamId)
                        .map((t) => DropdownMenuItem(value: t.id, child: Text(t.name)))
                        .toList(),
                    onChanged: (v) => setModalState(() => vTeamId = v),
                    validator: (v) => v == null ? "Sélectionnez une équipe" : null,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () {
                        if (_gameFormKey.currentState!.validate()) {
                          _gameFormKey.currentState!.save();

                          // Fusion de la date et de l'heure
                          final fullDateTime = DateTime(
                            selectedDate.year, selectedDate.month, selectedDate.day,
                            selectedTime.hour, selectedTime.minute,
                          );

                          final hGk = provider.getGoalkeeperByTeam(hTeamId!);
                          final vGk = provider.getGoalkeeperByTeam(vTeamId!);

                          if (hGk != null && vGk != null) {
                            provider.scheduleGame(
                              Game(
                                id: DateTime.now().toString(),
                                date: fullDateTime,
                                homeTeamId: hTeamId!,
                                visitorTeamId: vTeamId!,
                                whereIsGame: _location,
                                homeGkStats: GoalkeeperGameStats(goalkeeperId: hGk.id),
                                visitorGkStats: GoalkeeperGameStats(goalkeeperId: vGk.id),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Chaque équipe doit avoir un gardien !"),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Créer le match", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //int pageIndex = 0;
    //Utilisation du provider pour fournir les pages de la bottomnavigation bar
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          appBar: AppBars(onPressed: () {}),
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
          floatingActionButton: FloatingButtons(
            onPressed: () => _showScheduleGameModal(context),
          ),
        );
      },
    );
  }
}
