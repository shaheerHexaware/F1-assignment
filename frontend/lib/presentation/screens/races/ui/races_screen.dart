import 'package:f1_app/presentation/components/error_component.dart';
import 'package:f1_app/presentation/components/loading_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/data_repository.dart';
import '../../../../domain/models/driver/driver.dart';
import '../races_bloc.dart';
import '../event/races_event.dart';
import '../state/races_state.dart';
import 'races_list.dart';

class RacesScreenAttributes {
  final int season;
  final Driver champion;

  RacesScreenAttributes({required this.season, required this.champion});
}

class RacesScreen extends StatelessWidget {
  static const routeName = "races";

  final RacesScreenAttributes attributes;
  const RacesScreen({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RacesBloc(
        repository: context.read<DataRepository>(),
        seasonChampion: attributes.champion,
      )..add(RacesEvent.loadRaces(attributes.season)),
      child: Scaffold(
        appBar: AppBar(title: Text('${attributes.season} Races')),
        body: BlocBuilder<RacesBloc, RacesState>(
          builder: (context, state) {
            return state.map(
              loading: (_) => const LoadingComponent(),
              loaded: (state) => RacesList(races: state.races),
              error: (state) => ErrorComponent(
                onRetryTap: () {
                  context.read<RacesBloc>().add(
                    RacesEvent.loadRaces(attributes.season),
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
