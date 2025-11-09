import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/utilities.dart';
import 'package:pododoro/main.dart' show isar;
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/features/home/add_timer.dart';

class TimerPage extends StatefulWidget {
  final List<Timer> timers;
  final Function(String?) onSelectTimer;
  final String? activeTimerName;

  const TimerPage({super.key, required this.timers, required this.activeTimerName, required this.onSelectTimer});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.activeTimerName != null) {
      _selectedIndex = widget.timers.indexWhere((timer) => timer.name == widget.activeTimerName);
    }

    return Scaffold(
      backgroundColor: Constants.timerBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Timers", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.separated(
          itemCount: widget.timers.length,
          itemBuilder: (BuildContext context, int index) {
            final bool isSelected = index == _selectedIndex;

            return ListTile(
              title: Text(widget.timers[index].name!),
              subtitle: Text(
                Utilities.getTimeUnitDisplay(widget.timers[index].totalWorkMinutes, widget.timers[index].totalWorkSeconds)
              ),
              onTap: () {
                setState(() => _selectedIndex = index);
                widget.onSelectTimer(widget.timers[index].name);
              },
              selected: isSelected,
              selectedColor: Colors.orange,
              selectedTileColor: Colors.red,
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text("Delete"),
                          onTap: () {
                            _removeTimer(widget.timers[index].id);
                            Navigator.pop(context);
                          },
                        ),
                      ]
                    );
                  }
                );
              },
              tileColor: Colors.teal,
              leading: Icon(Icons.timelapse),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10.0,);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return AddTimerWidget(onAdd: _addTimer);
            }
          );
        },
        tooltip: 'Add timer',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Adds a timer to the internal database.
  Future _addTimer(String name, int workMinutes, int workSeconds, int restMinutes, int restSeconds) async{
    Timer timer = Timer(name: name, totalWorkMinutes: workMinutes, totalWorkSeconds: workSeconds, totalRestMinutes: restMinutes, totalRestSeconds: restSeconds);
    await isar.writeTxn(() async => await isar.timers.put(timer));

    setState(() => widget.timers.add(timer));
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimer(int id) async {
    Timer? timer = await isar.timers.get(id);

    if (timer == null) return false;

    bool success = await isar.writeTxn(() async => isar.timers.delete(id));

    if (!success) return false;

    setState(() => widget.timers.remove(timer));

    return success;
  }

  // /// Removes all timers from the internal database.
  // Future _removeAllTimers() async {
  //   await isar.timers.clear();
  //   setState(() => widget.timers.clear());
  // }
}