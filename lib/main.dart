import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scratch/Models/db_model.dart';
import 'package:scratch/Screens/home.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TournamentAdapter());
  Hive.registerAdapter(TeamAdapter());
  Hive.registerAdapter(MatchAdapter());
  await Hive.openBox<Tournament>('Tournament');
  await Hive.openBox<Team>('Team');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
