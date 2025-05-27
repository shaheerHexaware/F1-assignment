import 'package:f1_app/presentation/screens/races/models/race_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RaceListItem extends StatelessWidget {
  final RaceUi race;

  const RaceListItem({super.key, required this.race});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: race.isWinnerChampion ? 6 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: race.isWinnerChampion ? theme.colorScheme.primaryFixed : null,
        child: Stack(
          children: [
            Positioned(
              bottom: 16,
              right: 16,
              child: SvgPicture.asset(
                'assets/icons/formula1.svg',
                width: 56,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.primary.withAlpha(70),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    child: Text(
                      race.round.toString(),
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(race.name, style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text('Winner: ${race.driverName}'),
                        Text('Team: ${race.constructorName}'),
                        Text('Circuit: ${race.circuitName}'),
                        Text('Date: ${race.date}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
