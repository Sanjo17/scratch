import 'package:flutter/material.dart';
import 'package:scratch/Screens/singletournament.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournament Scheduler"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SingleTournament();
                }));
              },
              child: const Text("Single-KnockOut")),
          ElevatedButton(onPressed: () {}, child: const Text("Round-Robin")),
        ]),
      ),
    );
  }
}
