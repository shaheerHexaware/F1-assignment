import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_repository.dart';
import 'seasons_bloc.dart';
import 'seasons_event.dart';
import 'seasons_state.dart';
import '../../../presentation/screens/races/races_screen.dart';

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
              initial: (_) => const SizedBox(),
              loading: (_) => const Center(child: CircularProgressIndicator()),
              loaded: (state) => ListView.builder(
                itemCount: state.seasons.length,
                itemBuilder: (context, index) {
                  final season = state.seasons[index];
                  return ListTile(
                    title: Text('${season.year} Season'),
                    subtitle: Text('Champion: ${season.champion.fullName}'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RacesScreen.routeName,
                        arguments: RacesScreenAttributes(
                          season: season.year,
                          champion: season.champion,
                        ),
                      );
                    },
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
                        context.read<SeasonsBloc>().add(
                          const SeasonsEvent.loadSeasons(),
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
