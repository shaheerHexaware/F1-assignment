import 'package:f1_app/presentation/screens/races/models/race_ui.dart';
import 'package:flutter/material.dart';

import 'races_list_item.dart';

class RacesList extends StatelessWidget {
  final List<RaceUi> races;

  const RacesList({super.key, required this.races});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: races.length,
      itemBuilder: (context, index) {
        final race = races[index];
        return RaceListItem(race: race);
      },
    );
  }
}
