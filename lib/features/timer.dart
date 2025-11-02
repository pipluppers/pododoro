import 'package:isar/isar.dart';

part 'timer.g.dart';

@collection
class Timer {
  Id id = Isar.autoIncrement;

  String? name;
  int? totalMinutes;
  int? totalSeconds;
}