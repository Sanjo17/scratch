import 'package:hive/hive.dart';
import 'package:scratch/Models/db_model.dart';

class Boxes{
  static Box<Tournament> getTournament()=> Hive.box<Tournament>('Tournament');
  static Box<Team> getTeam() => Hive.box<Team>('Team');
}