import 'package:flutter/material.dart';

import '../Box/boxes.dart';
import '../Models/db_model.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> teams = [];
  List teamA = [];
  List teamB = [];
  List matches = [];
  List winners = [];
  int rounds = 1;
  @override
  void initState() {
    super.initState();
    final teambox = Boxes.getTeam();
    Team? data = teambox.getAt(0);
    // ignore: avoid_print
    print(teambox.name);
    // ignore: avoid_print
    print(data!.name);
    putTeamsToList();
    print(teams);
    fillbye(teams);
    print(teams);
    print(teams.length);
    print(teamA[0]);
    print(teamB[0]);
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

    int cc = teams.length ~/ 2;

    for (int i = 0; i <= cc; i++) {
      teamA.add(teams[i]);
    }
    for (int i = cc; i < teams.length; i++) {
      teamB.add(teams[i]);
    }

    int ccc = teams.length - 1;
    for (int i = 0; i < ccc; i++) {
      final team1 = teams[i];
      final team2 = teams[i + 1];
      matches.add('$team1 vs $team2');
    }
  }

  void putTeamsToList() {
    final teambox = Boxes.getTeam();

    var count = teambox.length;

    for (int i = 0; i < count; i++) {
      Team? dataa = teambox.getAt(i);
      teams.add(dataa!.name);
    }

    // void putToAB(List<String> team)  {
    //   int c = teams.length ~/ 2;

    //   for (int i = 0; i < c; i++) {
    //     teamA.add(teams[i]);
    //   }
    //   for (int i = c; i < teams.length; i++) {
    //     teamB.add(teams[i]);
    //   }
    // }

    //print(teambox.values.first);
  }

  @override
  Widget build(BuildContext context) {
    //int c = pow(teams.length, 1 / 3).toInt() + 1;
    int c = matches.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Match - Round $rounds"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: c,
        itemBuilder: (context, index) {
          print("${c}l");

          // return ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: teams.length,
          //   itemBuilder: (context, index) {
          //     print(index);

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: Center(child: Text(matches[index])),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("A")),
                    ElevatedButton(onPressed: () {}, child: const Text("B")),
                  ],
                )
              ],
            ),
          );
        },
      ),
      bottomSheet: ElevatedButton(
        onPressed: () {},
        child: const Text("Next round"),
      ),
    );
  }

  void getwinners(List match) {
    setState(() {
      winners.add(matches);
    });
  }
}
