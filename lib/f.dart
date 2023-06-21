import 'package:flutter/material.dart';

void main() {
  runApp(DartScheduleApp());
}

class DartScheduleApp extends StatelessWidget {
  const DartScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatelessWidget {
  final List<String> teams = [
    "Team 1",
    "Team 2",
    "Team 3",
    "Team 4",
    "Team 5",
    "Team 6",
    "Team 7",
    "Team 8",
  ];

  late List<List<List<String>>> schedule;

  SchedulePage({super.key}) {
    schedule = generateSchedule(teams);
  }

  @override
  Widget build(BuildContext context) {
    const int maxRoundsToShow = 3; // Maximum number of rounds to display
    final int totalRounds = schedule.length;
    final int roundsToShow =
        totalRounds > maxRoundsToShow ? maxRoundsToShow : totalRounds;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Schedule'),
      ),
      body: ListView.builder(
        itemCount: roundsToShow,
        itemBuilder: (context, index) {
          final roundIndex = totalRounds - index - 1;
          final roundSchedule = schedule[roundIndex];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Round ${roundIndex + 1}:',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: roundSchedule.map((match) {
                    return ListTile(
                      title: Text('${match[0]} vs ${match[1]}'),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<List<List<String>>> generateSchedule(List<String> teams) {
  // Shuffle the teams randomly
  teams.shuffle();

  // Check if the number of teams is a power of 2
  int numTeams = teams.length;
  if ((numTeams & (numTeams - 1)) != 0) {
    throw ArgumentError("Number of teams must be a power of 2.");
  }

  // Create the schedule
  List<List<List<String>>> schedule = [];
  while (teams.length > 1) {
    List<List<String>> roundSchedule = [];
    for (int i = 0; i < teams.length; i += 2) {
      List<String> match = [teams[i], teams[i + 1]];
      roundSchedule.add(match.toList());
    }
    schedule.add(roundSchedule);
    teams = [for (var match in roundSchedule) ...match];
  }

  return schedule;
}
