import 'package:isar/isar.dart';

part 'timer.g.dart';

@collection
class Timer {
  Id id = Isar.autoIncrement;

  String? name;
  int totalWorkMinutes;
  int totalWorkSeconds;
  int totalRestMinutes;
  int totalRestSeconds;

  Timer({this.name, this.totalWorkMinutes = 25, this.totalWorkSeconds = 0, this.totalRestMinutes = 5, this.totalRestSeconds = 0});

  @override
  bool operator ==(Object other) {
    if (other is Timer) {
      return name == other.name && totalWorkMinutes == other.totalWorkMinutes && totalWorkSeconds == other.totalWorkSeconds &&
        totalRestMinutes == other.totalRestMinutes && totalRestSeconds == other.totalRestSeconds;
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

    hashCode = hashCode + (totalWorkMinutes * 17) + (totalWorkSeconds * 17) + (totalRestMinutes * 17) + (totalRestSeconds * 17);
    // if (totalWorkMinutes != null) {
    // } else {
    //   hashCode += 17;
    // }

    // if (totalSeconds != null) {
    //   hashCode += (totalSeconds! * 17);
    // } else {
    //   hashCode += 17;
    // }

    return hashCode;
  }
}