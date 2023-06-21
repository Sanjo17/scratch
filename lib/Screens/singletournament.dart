import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:scratch/Box/boxes.dart';
import 'package:scratch/Models/db_model.dart';
import 'package:scratch/Screens/addteam.dart';

class SingleTournament extends StatefulWidget {
  const SingleTournament({super.key});

  @override
  State<SingleTournament> createState() => _SingleTournamentState();
}

class _SingleTournamentState extends State<SingleTournament> {
  @override
  void initState() {
    super.initState();
  }

  //final _tourbox = Hive.openBox<Tournament>('Tournament');
  TextEditingController titleController = TextEditingController();

  Future addTournament(
      int id, String name, DateTime startDate, DateTime endDate) async {
    final tournament =
        Tournament(id: id, name: name, startDate: startDate, endDate: endDate);
    final box = Boxes.getTournament();
    box.add(tournament);
    print(box.values);
    print(box.keys);
  }

  Future<void> deleteItsTeam(int tid) async {
    final ttbox = Boxes.getTeam();
    final teamsToDelete =
        ttbox.values.where((team) => team.tournamentId == tid).toList();
    for (var team in teamsToDelete) {
      team.delete();
    }
  }

  Future<void> deleteTournament(Tournament tournament, int tid) async {
    await deleteItsTeam(tid);

    tournament.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournaments"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              builder: (context) => Dialog(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(hintText: "Title"),
                          controller: titleController,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          child: const Text(
                            "Add Data",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            int index = 0;
                            final String title = titleController.text;
                            titleController.clear();
                            addTournament(
                                index, title, DateTime.now(), DateTime.now());

                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )),
              context: context);
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<Tournament>>(
        valueListenable: Boxes.getTournament().listenable(),
        builder: (context, box, _) {
          final tournament = box.values.toList().cast<Tournament>();
          return ListView.builder(
              itemCount: tournament.length,
              itemBuilder: (
                context,
                index,
              ) {
                Tournament? data = box.getAt(index);
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AddTeam(
                        tid1: data.id,
                      );
                    }));
                  },
                  title: Text(data!.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteTournament(data, data.id);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
