import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/goalkeeper.dart';

import '../models/teams.dart' show Teams;

class TeamsProvider extends ChangeNotifier {
  //liste equipes

  final List<Teams> _teams = [];

  //liste game / match
  final List<Game> _games = [];

  //liste des gardiens pour une team
  final List<Goalkeeper> _goalkeepers = [];

  List<Teams> get teams => _teams;

  List<Goalkeeper> get goalkeepers => _goalkeepers;

  List<Game> get games => _games;

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

  //ajouter une equipe
  void addTeam(Teams team) {
    _teams.add(team);
    notifyListeners(); // Prévient l'UI qu'il faut se rafraîchir
  }

  //supprimer une equipe
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

  // Ajouter un match programmé
  void scheduleGame(Game game) {
    _games.add(game);
    notifyListeners();
  }

  //mettre a jour des stat dun match /game
  void updateMatchResults({
    required String gameId,
    required int homeShots,
    required int homeGoals,
    required int visitorShots,
    required int visitorGoals,
  }) {
    int index = _games.indexWhere((g) => g.id == gameId);
    if (index != -1) {
      _games[index].homeGkStats.shotsAgainst = homeShots;
      _games[index].homeGkStats.goalsAgainst = homeGoals;

      _games[index].visitorGkStats.shotsAgainst = visitorShots;
      _games[index].visitorGkStats.goalsAgainst = visitorGoals;

      _games[index].isFinished = true;
      notifyListeners();
    }
  }

// Trouver un gardien par son équipe
  Goalkeeper? getGoalkeeperByTeam(String teamId) {
    try {
      return _goalkeepers.firstWhere((g) => g.teamId == teamId);
    } catch (e) {
      // Si aucun gardien n'est trouvé, on retourne null au lieu de faire planter l'app
      return null;
    }
  }

}
