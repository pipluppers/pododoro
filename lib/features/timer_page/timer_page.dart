import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/utilities.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/features/timer_page/add_timer.dart';
import 'package:isar/isar.dart';

class TimerPage extends StatefulWidget {
  final Isar isar;
  final List<Timer> timers;
  final Function(String?) onSelectTimer;

  const TimerPage({super.key, required this.isar, required this.timers, required this.onSelectTimer});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
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
            return ListTile(
              title: Text(widget.timers[index].name!),
              subtitle: Text(
                Utilities.getTimeUnitDisplay(widget.timers[index].totalMinutes, widget.timers[index].totalSeconds)
              ),
              onTap: () {
                widget.onSelectTimer(widget.timers[index].name);
                Navigator.pop(context);
              },
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
  Future _addTimer(String name, int totalMinutes, int totalSeconds) async{
    Timer timer = Timer(name: name, totalMinutes: totalMinutes, totalSeconds: totalSeconds);
    await widget.isar.writeTxn(() async => await widget.isar.timers.put(timer));

    setState(() => widget.timers.add(timer));
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimer(int id) async {
    Timer? timer = await widget.isar.timers.get(id);

    if (timer == null) return false;

    bool success = await widget.isar.writeTxn(() async => widget.isar.timers.delete(id));

    if (!success) return false;

    setState(() => widget.timers.remove(timer));

    return success;
  }

  /// Removes all timers from the internal database.
  Future _removeAllTimers() async {
    await widget.isar.timers.clear();
    setState(() => widget.timers.clear());
  }
}