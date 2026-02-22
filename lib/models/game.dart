import 'goalkeeper.game.stat.dart';

class Game {
  final String id;
  final DateTime date; //combiner heure et date
  final String homeTeamId;
  final String visitorTeamId;
  final String whereIsGame;
  // On stocke les stats des deux gardiens
  final GoalkeeperGameStats homeGkStats;
  final GoalkeeperGameStats visitorGkStats;

  bool isFinished;   //savoir si le match a eu ou non les stats<=> match joué et fini
  Game({
    required this.id,
    required this.date,
    required this.homeTeamId,
    required this.visitorTeamId,
    required this.whereIsGame,
    required this.homeGkStats,
    required this.visitorGkStats,
    this.isFinished = false,
  });

}
