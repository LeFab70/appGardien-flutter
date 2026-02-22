import 'package:flutter/material.dart';
import '../../../../models/goalkeeper.dart';
import '../../../../models/teams.dart';
import '../../colors/colors.app.dart';

class GoalkeeperRowDetails extends StatelessWidget {
  final Goalkeeper goalkeeper;
  final Teams? team; // Pour afficher le logo et nom de l'équipe associée

  const GoalkeeperRowDetails({super.key, required this.goalkeeper, this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundLight,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            goalkeeper.name[0],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          goalkeeper.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Taille: ${goalkeeper.height}m | ${goalkeeper.nationality}",
        ),
        trailing: team != null
            ? SizedBox(
                width: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // TRÈS IMPORTANT
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      team!.urlLogo,
                      width: 25,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    Text(
                      team!.name,
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ), // Si le nom est trop long),
                  ],
                ),
              )
            : const Icon(Icons.help_outline),
      ),
    );
  }
}
