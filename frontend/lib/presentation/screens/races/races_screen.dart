import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import '../../../domain/models/driver/driver.dart';
import 'races_bloc.dart';
import 'races_event.dart';
import 'races_state.dart';

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
              initial: (_) => const SizedBox(),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (state) => ListView.builder(
                itemCount: state.races.length,
                itemBuilder: (context, index) {
                  final race = state.races[index];
                  final isChampionWinner =
                      race.winner.driverId == state.seasonChampion.driverId;

                  return ListTile(
                    title: Text(race.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Circuit: ${race.circuit.circuitName}'),
                        Text(
                          'Location: ${race.circuit.location.locality}, ${race.circuit.location.country}',
                        ),
                        Text('Winner: ${race.winner.fullName}'),
                        Text('Team: ${race.constructor.name}'),
                      ],
                    ),
                    tileColor: isChampionWinner
                        ? Colors.amber.withOpacity(0.2)
                        : null,
                    leading: Text(
                      'R${index + 1}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    isThreeLine: true,
                  );
                },
              ),
              error: (state) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RacesBloc>().add(
                          RacesEvent.loadRaces(attributes.season),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
