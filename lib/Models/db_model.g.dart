// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentAdapter extends TypeAdapter<Tournament> {
  @override
  final int typeId = 0;

  @override
  Tournament read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tournament(
      id: fields[0] as int,
      name: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Tournament obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeamAdapter extends TypeAdapter<Team> {
  @override
  final int typeId = 1;

  @override
  Team read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Team(
      id: fields[0] as int,
      name: fields[1] as String,
      tournamentId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Team obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tournamentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MatchAdapter extends TypeAdapter<Match> {
  @override
  final int typeId = 2;

  @override
  Match read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Match(
      id: fields[0] as int,
      team1Id: fields[1] as int,
      team2Id: fields[2] as int,
      score1: fields[3] as int,
      score2: fields[4] as int,
      winnerId: fields[5] as int,
      tournamentId: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Match obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.team1Id)
      ..writeByte(2)
      ..write(obj.team2Id)
      ..writeByte(3)
      ..write(obj.score1)
      ..writeByte(4)
      ..write(obj.score2)
      ..writeByte(5)
      ..write(obj.winnerId)
      ..writeByte(6)
      ..write(obj.tournamentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
