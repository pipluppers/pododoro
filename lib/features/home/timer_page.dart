import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pododoro/constants.dart';
import 'package:pododoro/data_management/database_service.dart';
import 'package:pododoro/resources/string_resources.dart';
import 'package:pododoro/utilities.dart' show Utilities;
import 'package:pododoro/features/home/add_timer.dart';
import 'package:get_it/get_it.dart' show GetIt;

class TimerPage extends StatefulWidget {
  final List<ITimer> timers;
  final Function(String) onSelectTimer;
  final String? activeTimerName;

  const TimerPage({super.key, required this.timers, required this.activeTimerName, required this.onSelectTimer});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _selectedIndex = 0;
  late FToast flutterToast;

  @override void initState() {
    super.initState();

    flutterToast = FToast();
    flutterToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.activeTimerName != null) {
      _selectedIndex = widget.timers.indexWhere((timer) => timer.name == widget.activeTimerName);
    }

    return Scaffold(
      backgroundColor: Constants.mainPageBackgroundColor,
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

            return Dismissible(
              key: ValueKey<ITimer>(widget.timers[index]),
              background: Container(
                color: Constants.removeTimerSwipeColor,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8.0,),
                child: Icon(Constants.cancelIcon,),
              ),
              secondaryBackground: Container(color: Constants.mainPageBackgroundColor),
              onDismissed: (direction) {
                // Remove the timer if user swiped right
                if (direction == DismissDirection.startToEnd) {
                  _removeTimer(widget.timers[index]);                 
                }
              },
              confirmDismiss: (direction) async {
                if (direction != DismissDirection.startToEnd) {
                  return false;
                }

                ITimer swipedTimer = widget.timers[index];

                if (swipedTimer.isDefaultTimer) {
                  Utilities.showToast(flutterToast, StringResources.removeDefaultTimerErrorMessage);
                  return false;
                }

                if (widget.activeTimerName == swipedTimer.name) {
                  Utilities.showToast(flutterToast, StringResources.removeActiveTimerErrorMessage);
                  return false;
                }

                return true;
              },
              child: ListTile(
                title: Text(
                  widget.timers[index].name,
                  style: const TextStyle(color: Constants.mainPageComplementTextColor,),
                ),
                subtitle: Text(
                  Utilities.getTimeUnitDisplay(widget.timers[index].totalWorkMinutes, widget.timers[index].totalWorkSeconds),
                  style: const TextStyle(color: Constants.mainPageComplementTextColor,),
                ),
                onTap: () {
                  setState(() => _selectedIndex = index);
                  widget.onSelectTimer(widget.timers[index].name);
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
                              _removeTimerById(widget.timers[index].id);
                              Navigator.pop(context);
                            },
                          ),
                        ]
                      );
                    }
                  );
                },
                selected: isSelected,
                selectedColor: Colors.orange,
                selectedTileColor: Constants.selectedTimerTileColor,
                tileColor: Constants.mainPageComplementColor,
                leading: Icon(Icons.timelapse),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
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
    final DatabaseService databaseService = GetIt.I<DatabaseService>();

    int newTimerId = await databaseService.addTimer(name, workMinutes, workSeconds, restMinutes, restSeconds);

    setState(() => widget.timers.add(databaseService.constructTimer(newTimerId, name, workMinutes, workSeconds, restMinutes, restSeconds)));
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimerById(int id) async {
    DatabaseService databaseService = GetIt.I<DatabaseService>();

    ITimer? timer = await databaseService.getTimer(id);

    if (timer == null) return false;

    return _removeTimer(timer, databaseService: databaseService);
  }

  /// Removes a specified timer from the internal database.
  Future<bool> _removeTimer(ITimer timer, {DatabaseService? databaseService}) async {
    if (timer.isDefaultTimer) {
      // The default timer may not be deleted
      Utilities.showToast(flutterToast, StringResources.removeDefaultTimerErrorMessage);
      return false;
    }

    databaseService ??= GetIt.I<DatabaseService>();

    bool success = await databaseService.removeTimer(timer.id);

    if (!success) return false;

    setState(() => widget.timers.remove(timer));

    return success;
  }
}