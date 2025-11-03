import 'package:isar/isar.dart';

part 'timer.g.dart';

@collection
class Timer {
  Id id = Isar.autoIncrement;

  String? name;
  int? totalMinutes;
  int? totalSeconds;

  Timer({this.name, this.totalMinutes, this.totalSeconds});

  @override
  bool operator ==(Object other) {
    if (other is Timer) {
      return name == other.name && totalMinutes == other.totalMinutes && totalSeconds == other.totalSeconds;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode {
    int hashCode = 0;

    if (name != null) {
      for (int i = 0; i < name!.length; i++) {
        hashCode = name!.codeUnitAt(i);
      }
    } else {
      hashCode += 34;
    }

    if (totalMinutes != null) {
      hashCode += (totalMinutes! * 17);
    } else {
      hashCode += 17;
    }

    if (totalSeconds != null) {
      hashCode += (totalSeconds! * 17);
    } else {
      hashCode += 17;
    }

    return hashCode;
  }
}