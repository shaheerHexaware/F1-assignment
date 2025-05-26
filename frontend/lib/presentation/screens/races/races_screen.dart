import 'package:flutter/material.dart';

import '../../../domain/models/driver/driver.dart';

class RacesScreenAttributes {
  final int season;
  final Driver champion;

  RacesScreenAttributes({required this.season, required this.champion});
}

class RacesScreen extends StatefulWidget {
  static const routeName = "races";

  final RacesScreenAttributes attributes;
  const RacesScreen({super.key, required this.attributes});

  @override
  State<RacesScreen> createState() => _RacesScreenState();
}

class _RacesScreenState extends State<RacesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
