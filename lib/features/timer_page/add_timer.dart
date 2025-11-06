import 'package:flutter/material.dart';
import 'package:pododoro/features/timer_page/timer_row.dart';

class AddTimerWidget extends StatefulWidget {
  final Function(String, int, int) onAdd;

  const AddTimerWidget({super.key, required this.onAdd});

  @override
  State<AddTimerWidget> createState() => _AddTimerWidgetState();
}

class _AddTimerWidgetState extends State<AddTimerWidget> {
  String? _name;
  int? _totalMinutes;
  int? _totalSeconds;

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
              header: "Total minutes",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _totalMinutes = int.tryParse(value),
            ),
            TimerRow(
              header: "Total seconds",
              textInputType: TextInputType.number,
              onTextChanged: (value) => _totalSeconds = int.tryParse(value),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAdd(_name!, _totalMinutes!, _totalSeconds!);
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