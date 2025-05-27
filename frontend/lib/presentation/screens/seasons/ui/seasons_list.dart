import 'package:f1_app/domain/models/season/season.dart';
import 'package:flutter/material.dart';

import 'seasons_list_item.dart';

class SeasonsList extends StatelessWidget {
  final List<Season> seasons;
  final Function(Season season) onSeasonSelected;

  const SeasonsList({
    super.key,
    required this.seasons,
    required this.onSeasonSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: seasons.length,
      itemBuilder: (context, index) {
        final season = seasons[index];
        return SeasonListItem(
          season: season,
          onTap: () => onSeasonSelected(season),
        );
      },
    );
  }
}
