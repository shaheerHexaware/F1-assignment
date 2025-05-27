import 'package:f1_app/presentation/screens/seasons/ui/seasons_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/data_repository.dart';
import '../../../components/error_component.dart';
import '../../../components/loading_component.dart';
import '../seasons_bloc.dart';
import '../event/seasons_event.dart';
import '../state/seasons_state.dart';
import '../../races/races_screen.dart';

class SeasonsScreen extends StatelessWidget {
  static const routeName = "seasons";
  const SeasonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SeasonsBloc(repository: context.read<DataRepository>())
            ..add(const SeasonsEvent.loadSeasons()),
      child: Scaffold(
        appBar: AppBar(title: const Text('F1 Seasons')),
        body: BlocBuilder<SeasonsBloc, SeasonsState>(
          builder: (context, state) {
            return state.map(
              loading: (_) => const LoadingComponent(),
              loaded: (state) => SeasonsList(
                seasons: state.seasons,
                onSeasonSelected: (season) {
                  Navigator.pushNamed(
                    context,
                    RacesScreen.routeName,
                    arguments: RacesScreenAttributes(
                      season: season.year,
                      champion: season.champion,
                    ),
                  );
                },
              ),
              error: (state) => ErrorComponent(
                onRetryTap: () {
                  context.read<SeasonsBloc>().add(
                    const SeasonsEvent.loadSeasons(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
