import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scratch/Models/db_model.dart';
import 'package:scratch/Screens/test.dart';

import '../Box/boxes.dart';

class AddTeam extends StatefulWidget {
  int tid1;
  AddTeam({super.key, required this.tid1});

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  TextEditingController teamController = TextEditingController();

  Future addTeam(int id, String name, int tid) async {
    final team = Team(id: id, name: name, tournamentId: tid);
    final box = Boxes.getTeam();
    box.add(team);
    print(box.values);
    print(box.keys);
  }

  void deleteTeam(Team team) {
    team.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teams"),
      ),
      body: ValueListenableBuilder<Box<Team>>(
        valueListenable: Boxes.getTeam().listenable(),
        builder: (context, box, tid) {
          final team = box.values.toList().cast<Team>();

          // final team =
          //     box.values.where((team) => team.tournamentId == tid).toList();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: team.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      Team? data = box.getAt(index);
                      return ListTile(
                        title: Text(data!.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteTeam(data);
                          },
                        ),
                      );
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const Test();
                    }));
                  },
                  child: const Text(
                    "Schedule",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              builder: (
                context,
              ) =>
                  Dialog(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          decoration: const InputDecoration(hintText: "Title"),
                          controller: teamController,
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

                            final String title = teamController.text;
                            teamController.clear();

                            // ignore: unnecessary_null_comparison
                            if (index != null) {
                              addTeam(index, title, 0);
                              index++;
                            } else {
                              addTeam(index, title, 0);
                            }

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
      // bottomSheet: ElevatedButton(
      //   child: const Text("shedule"),
      //   onPressed: () {},
      // ),
    );
  }
}
