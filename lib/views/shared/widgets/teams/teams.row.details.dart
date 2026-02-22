import 'package:flutter/material.dart';
import 'package:test1_appgardienbut_fabrice/views/shared/colors/colors.app.dart';
import '../../../../models/teams.dart';

class TeamsRowDetails extends StatelessWidget {
  final Teams team;

  const TeamsRowDetails({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundLight,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(team.urlLogo),
          onBackgroundImageError: (_, __) =>
              const Icon(Icons.group), //si url echoue
        ),
        title: Text(
          team.name,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          ('Manager: ${team.managerName}'),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),

        trailing: Text(
          "${team.country.flagEmoji} ${team.country.name}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
