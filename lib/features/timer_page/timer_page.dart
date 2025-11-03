import 'package:flutter/material.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/utilities.dart';

class TimerPage extends StatefulWidget {
  final List<Timer> timers;
  final Function(String?) onSelectTimer;
  final Function(int) onDeleteTimer;

  const TimerPage({super.key, required this.timers, required this.onSelectTimer, required this.onDeleteTimer});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Timers", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: widget.timers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.timers[index].name!),
            subtitle: Text(Utilities.getTimeUnitDisplay(widget.timers[index].totalMinutes, widget.timers[index].totalSeconds)),
            tileColor: Colors.teal,
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
                        onTap: () => widget.onDeleteTimer(widget.timers[index].id)
                      ),
                    ]
                  );
                }
              );
            },
          );
        }
      ),
    );
  }
}