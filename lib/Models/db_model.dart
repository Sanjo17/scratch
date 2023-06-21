import 'package:hive/hive.dart';

part 'db_model.g.dart';

@HiveType(typeId: 0)
class Tournament extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime startDate;

  @HiveField(3)
  DateTime endDate;

  

  Tournament(
      {required this.id,
      required this.name,
      required this.startDate,
      required this.endDate});
}

@HiveType(typeId: 1)
class Team extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int tournamentId;

  Team({required this.id, required this.name, required this.tournamentId});
}

@HiveType(typeId: 2)
class Match extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int team1Id;

  @HiveField(2)
  int team2Id;

  @HiveField(3)
  int score1;

  @HiveField(4)
  int score2;

  @HiveField(5)
  int winnerId;

  @HiveField(6)
  int tournamentId;

  Match({
    required this.id,
    required this.team1Id,
    required this.team2Id,
    required this.score1,
    required this.score2,
    required this.winnerId,
    required this.tournamentId,
  });
}
