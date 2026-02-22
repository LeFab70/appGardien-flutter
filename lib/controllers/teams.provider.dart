import 'package:flutter/material.dart';
import '../models/goalkeeper.dart';

import '../models/teams.dart' show Teams;

class TeamsProvider extends ChangeNotifier {
  final List<Teams> _teams = [];

  //liste des gardiens pour une team
  final List<Goalkeeper> _goalkeepers = [];

  List<Teams> get teams => _teams;

  List<Goalkeeper> get goalkeepers => _goalkeepers;

  //Retourne les équipes qui n'ont PAS encore de gardien
  List<Teams> get teamsWithoutGoalkeeper {
    // On récupère tous les IDs des équipes qui ont déjà un gardien
    final occupiedTeamIds = _goalkeepers.map((g) => g.teamId).toSet();

    // On retourne seulement les équipes dont l'ID n'est pas dans la liste occupée
    return _teams.where((team) => !occupiedTeamIds.contains(team.id)).toList();
  }

  //ajouter un gardien à une equipe
  void addGoalkeeper(Goalkeeper goalkeeper) {
    _goalkeepers.add(goalkeeper);
    notifyListeners(); // La dropdown se mettra à jour automatiquement !
  }

  // SUPPRESSION D'UN GARDIEN
  void deleteGoalkeeper(String goalkeeperId) {
    _goalkeepers.removeWhere((g) => g.id == goalkeeperId);
    notifyListeners(); // L'équipe redevient disponible dans la dropdown !
  }

  void addTeam(Teams team) {
    _teams.add(team);
    notifyListeners(); // Prévient l'UI qu'il faut se rafraîchir
  }

  void deleteTeam(int index) {
    // On récupère l'ID de l'équipe avant de la supprimer de la liste
    String teamIdToDelete = _teams[index].id;

    //On supprime les gardiens liés à cet ID
    // (Sinon ils resteront en mémoire sans équipe)
    _goalkeepers.removeWhere((g) => g.teamId == teamIdToDelete);

    //  On supprime l'équipe à l'index d
    _teams.removeAt(index);

    notifyListeners();
  }
}
