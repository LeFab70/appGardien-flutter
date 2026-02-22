class GoalkeeperGameStats {
  final String goalkeeperId;
  int shotsAgainst;
  int goalsAgainst;

  GoalkeeperGameStats({
    required this.goalkeeperId,
    this.shotsAgainst = 0,
    this.goalsAgainst = 0,
  });

  //pourcentage de chaque gardien sur 2 chiffres
  double get savePercentage {
    if (shotsAgainst == 0) return 0.0;
    return double.parse((((shotsAgainst - goalsAgainst) / shotsAgainst) * 100).toStringAsFixed(2));
  }
}