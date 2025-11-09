import 'package:flutter/material.dart';
import 'package:pododoro/features/home/timer_row.dart';

class AddTimerWidget extends StatefulWidget {
  final Function(String, int, int, int, int) onAdd;

  const AddTimerWidget({super.key, required this.onAdd});

  @override
  State<AddTimerWidget> createState() => _AddTimerWidgetState();
}

class _AddTimerWidgetState extends State<AddTimerWidget> {
  String? _name;
  int? _workMinutes;
  int? _workSeconds;
  int? _restMinutes;
  int? _restSeconds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This padding will make sure the content is above the keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min, // prevents the dialog from taking up the whole screen
          children: [
            TimerRow(
              header: "Name",
              onTextChanged: (value) => _name = value,
            ),
            TimerRow(
              header: "Total minutes to work",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _workMinutes = int.tryParse(value),
            ),
            TimerRow(
              header: "Total seconds to work",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _workSeconds = int.tryParse(value),
            ),
            TimerRow(
              header: "Total minutes to rest",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _restMinutes = int.tryParse(value),
            ),
            TimerRow(
              header: "Total seconds to rest",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _restSeconds = int.tryParse(value),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAdd(_name!, _workMinutes!, _workSeconds!, _restMinutes!, _restSeconds!);
                Navigator.pop(context);
              },
              child: const Text("Add")
            ),
          ],
        ),
      ),
    );
  }
}