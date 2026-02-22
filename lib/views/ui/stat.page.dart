import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1_appgardienbut_fabrice/views/shared/styles/app.style.dart';

import '../../controllers/teams.provider.dart';
import '../../models/game.dart';
import '../../models/teams.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  void _showInputStatsModal(BuildContext context, Game game) {
    final provider = Provider.of<TeamsProvider>(context, listen: false);
    // Contrôleurs pour récupérer les textes saisis
    final hShotsController = TextEditingController();
    final hGoalsController = TextEditingController();
    final vShotsController = TextEditingController();
    final vGoalsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // Pour monter la modale quand le clavier sort
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Saisie des Statistiques",
                  style: appStyle(20, Colors.black, FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // ÉQUIPE DOMICILE
                _buildGkInputSection(
                  context,
                  title: "Gardien Domicile",
                  shotsCtrl: hShotsController,
                  goalsCtrl: hGoalsController,
                ),

                const Divider(height: 40),

                // ÉQUIPE VISITEUR
                _buildGkInputSection(
                  context,
                  title: "Gardien Visiteur",
                  shotsCtrl: vShotsController,
                  goalsCtrl: vGoalsController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      // Validation simple
                      if (hShotsController.text.isEmpty ||
                          vShotsController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Veuillez remplir au moins les lancers contre",
                            ),
                          ),
                        );
                        return;
                      }

                      // 1. Conversion des textes en entiers (avec sécurité)
                      int hShots = int.tryParse(hShotsController.text) ?? 0;
                      int hGoals = int.tryParse(hGoalsController.text) ?? 0;
                      int vShots = int.tryParse(vShotsController.text) ?? 0;
                      int vGoals = int.tryParse(vGoalsController.text) ?? 0;
                      // Appel au provider pour mettre à jour le match
                      provider.updateMatchResults(
                        gameId: game.id,
                        homeShots: hShots,
                        homeGoals: hGoals,
                        visitorShots: vShots,
                        visitorGoals: vGoals,
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Statistiques mises à jour !"),
                        ),
                      );
                    },
                    child: const Text(
                      "Enregistrer le résultat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget utilitaire pour créer les champs de saisie par gardien
  Widget _buildGkInputSection(
    BuildContext context, {
    required String title,
    required TextEditingController shotsCtrl,
    required TextEditingController goalsCtrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: shotsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Lancers contre",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: goalsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Buts encaissés",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // On écoute les changements dans TeamsProvider
    return Consumer<TeamsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.games.isEmpty
              ? const Center(child: Text("Aucun match programmé"))
              : ListView.builder(
                  itemCount: provider.games.length,
                  itemBuilder: (context, index) {
                    final game = provider.games[index];
                    final homeTeam = provider.teams.firstWhere(
                      (t) => t.id == game.homeTeamId,
                    );
                    final visitorTeam = provider.teams.firstWhere(
                      (t) => t.id == game.visitorTeamId,
                    );

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ExpansionTile(
                        title: Text("${homeTeam.name} vs ${visitorTeam.name}"),
                        subtitle: Text(
                          game.isFinished
                              ? "✅ Terminé"
                              : "⏳ En attente de stats",
                        ),
                        children: [
                          if (!game.isFinished)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _showInputStatsModal(context, game),
                                icon: const Icon(Icons.edit),
                                label: const Text("Saisir les résultats"),
                              ),
                            )
                          else
                            _buildStatsSummary(game, homeTeam, visitorTeam),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  // Widget simple pour afficher le résumé après saisie
  Widget _buildStatsSummary(Game game, Teams h, Teams v) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("${h.name} : ${game.homeGkStats.savePercentage}% d'arrêts"),
          Text("${v.name} : ${game.visitorGkStats.savePercentage}% d'arrêts"),
        ],
      ),
    );
  }
}
