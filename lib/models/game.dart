class Game {
  final String id;
  final DateTime date; // Combine date et heure pour plus de simplicité
  final String homeTeamId;
  final String visitorTeamId;
  final String goalkeeperId;
  int shotsAgainst;
  int goalsAgainst;

  Game({
    required this.id,
    required this.date,
    required this.homeTeamId,
    required this.visitorTeamId,
    required this.goalkeeperId,
    this.shotsAgainst = 0,
    this.goalsAgainst = 0,
  });

  // Calcul du pourcentage d'arrêts (Save Percentage)
  double get savePercentage {
    if (shotsAgainst == 0) return 0.0;

    // Formule: ((Lancers - Buts) / Lancers) * 100
    double percentage = ((shotsAgainst - goalsAgainst) / shotsAgainst) * 100;

    // On retourne le résultat arrondi à 2 décimales
    return double.parse(percentage.toStringAsFixed(2));
  }
}