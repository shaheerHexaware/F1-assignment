import 'package:f1_app/domain/models/season/season.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SeasonListItem extends StatelessWidget {
  final Season season;
  final VoidCallback onTap;

  const SeasonListItem({super.key, required this.season, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: SvgPicture.asset(
            'assets/icons/formula1.svg',
            width: 56,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
          title: Text(
            season.champion.fullName,
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(
            season.year.toString(),
            style: theme.textTheme.bodyMedium,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
