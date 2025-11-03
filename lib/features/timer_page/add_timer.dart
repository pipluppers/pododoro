import 'package:flutter/material.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TimerTextWidget(text: "Name"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                      right: 5.0,
                      bottom: 5.0
                    ),
                    child: TextField(
                      onSubmitted: (value) => _name = value,
                      cursorColor: Colors.white,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, width: 1.0
                          )
                        )
                      )
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TimerTextWidget(text: "Total minutes"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                      right: 5.0,
                      bottom: 5.0
                    ),
                    child: TextField(
                      onSubmitted: (value) => _totalMinutes = int.tryParse(value),
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, width: 1.0
                          )
                        )
                      )
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TimerTextWidget(text: "Total seconds"),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5.0,
                      right: 5.0,
                      bottom: 5.0
                    ),
                    child: TextField(
                      onSubmitted: (value) => _totalSeconds = int.tryParse(value),
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, width: 1.0
                          )
                        )
                      )
                    ),
                  ),
                )
              ],
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

class TimerTextWidget extends StatelessWidget {
  final String text;

  const TimerTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}