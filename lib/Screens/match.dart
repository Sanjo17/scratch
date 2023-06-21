import 'package:flutter/material.dart';
import 'package:scratch/Box/boxes.dart';
import 'dart:math';

import '../Models/db_model.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<String> teams = [];
  List<List<String>> rounds = [];
  List<List<String>> matchSchedule = [];
  List<List<String>> winners = [];

  int currentRound = 0;
  @override
  void initState() {
    super.initState();

    final teambox = Boxes.getTeam();
    Team? data = teambox.getAt(0);
    // print(teambox.name);
    //print(data!.name);
    // list indaki

    putTeamsToList();
    print(teams);
    fillbye(teams);
    print(teams);

    var nround = pow(teams.length, 2);

    //generateRounds();
    matchSchedule = singleKnockoutSchedule(teams);
    winners.add(teams);
    // List<String> schedule = SingleSchedule.generateFootballSchedule(teams);
    // printFootballSchedule(schedule);
  }

  void fillbye(List<String> team) {
    var c = team.length;
    if (c < 4) {
      int dif = 4 - c;
      for (int i = 0; i < dif; i++) {
        teams.add("bye");
      }
    } else if (c > 4 && c < 8) {
      int dif = 8 - c;
      for (int i = 0; i < dif; i++) {
        teams.add("bye");
      }
    } else if (c > 8 && c < 16) {
      int dif = 16 - c;
      for (int i = 0; i < dif; i++) {
        teams.add("bye");
      }
    } else if (c > 16 && c < 32) {
      int dif = 32 - c;
      for (int i = 0; i < dif; i++) {
        teams.add("bye");
      }
    }
  }

  List<List<String>> singleKnockoutSchedule(List<String> participants) {
    int totalParticipants = participants.length;
    int totalMatches = totalParticipants - 1.toRadixString(2).length;
    List<List<String>> schedule = [];

    // Randomize participants (optional)
    participants.shuffle();

    // Generate match pairings for each round
    for (int roundNum = 0; roundNum < totalMatches; roundNum++) {
      List<String> roundSchedule = [];
      for (int i = 0; i < totalParticipants; i += 2) {
        if (i + 1 < totalParticipants) {
          roundSchedule.add('${participants[i]} vs ${participants[i + 1]}');
        } else {
          // Handle bye for odd number of participants
          roundSchedule.add('${participants[i]} BYE');
        }
      }
      schedule.add(roundSchedule);

      // Update participants for the next round
      List<String> roundWinners = [];
      for (int j = 0; j < roundSchedule.length; j++) {
        String match = roundSchedule[j];
        if (!match.contains('BYE')) {
          int team1Score = 0;
          int team2Score = 0;

          // Simulating score input (replace with your logic to accept scores)
          if (roundNum > 0) {
            // Retrieve the scores of teams from previous rounds
            List<String> prevRoundWinners = winners[roundNum - 1];
            int teamIndex1 = participants.indexOf(match.split(' vs ')[0]);
            int teamIndex2 = participants.indexOf(match.split(' vs ')[1]);

            // Retrieve the scores of teams from the previous round
            team1Score = int.parse(prevRoundWinners[teamIndex1].split(':')[1]);
            team2Score = int.parse(prevRoundWinners[teamIndex2].split(':')[1]);
          }

          // Update the winners list based on scores
          if (team1Score > team2Score) {
            roundWinners.add('${match.split(' vs ')[0]}:$team1Score');
          } else {
            roundWinners.add('${match.split(' vs ')[1]}:$team2Score');
          }
        }
      }
      participants = roundWinners;
      totalParticipants = participants.length;
      winners.add(participants);
    }

    return schedule;
  }

  void goToNextRound() {
    setState(() {
      currentRound++;
    });
  }

  void generateRounds() {
    rounds.clear();
    List<String> currentRound = List.from(teams);
    while (currentRound.length > 1) {
      rounds.add(currentRound);
      currentRound = getNextRoundTeams(currentRound);
    }
    rounds.add(currentRound);
  }

  List<String> getNextRoundTeams(List<String> previousRound) {
    List<String> nextRound = [];
    for (int i = 0; i < previousRound.length; i += 2) {
      final team1 = previousRound[i];
      final team2 = previousRound[i + 1];
      nextRound.add('$team1 vs $team2');
    }
    return nextRound;
  }

  //list indaki

  void putTeamsToList() {
    final teambox = Boxes.getTeam();

    var count = teambox.length;

    for (int i = 0; i < count; i++) {
      Team? dataa = teambox.getAt(i);
      teams.add(dataa!.name);
    }

    print(teambox.values.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Schedule'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Round ${currentRound + 1}',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (currentRound < matchSchedule.length)
              Column(
                children: matchSchedule[currentRound]
                    .map((match) => Text(
                          match,
                          style: const TextStyle(fontSize: 20),
                        ))
                    .toList(),
              )
            else
              const Text('Tournament ended.'),
            const SizedBox(height: 20),
            if (currentRound < matchSchedule.length)
              ElevatedButton(
                onPressed: goToNextRound,
                child: const Text('Next Round'),
              ),
          ],
        ),
      ),
    );
  }
}

//   List<Widget> _buildTabItems() {
//     return rounds
//         .map((round) => Tab(text: 'Round ${rounds.indexOf(round) + 1}'))
//         .toList();
//   }

//   List<Widget> _buildTabViews() {
//     return rounds.map((round) => buildTournamentSchedule(round)).toList();
//   }

//   Widget buildTournamentSchedule(List<String> round) {
//     final List<Widget> matchWidgets = round
//         .map(
//           (match) => Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               match,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 18),
//             ),
//           ),
//         )
//         .toList();

//     return ListView(
//       children: matchWidgets,
//     );
//   }
// }

// Widget buildMatchWidget(String team1, String team2) {
//   return Container(
//     padding: const EdgeInsets.all(16.0),
//     child: Row(
//       children: [
//         Expanded(
//           child: Text(
//             team1,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 18),
//           ),
//         ),
//         const Text(
//           'vs',
//           style: TextStyle(fontSize: 18),
//         ),
//         Expanded(
//           child: Text(
//             team2,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 18),
//           ),
//         ),
//       ],
//     ),
//   );

