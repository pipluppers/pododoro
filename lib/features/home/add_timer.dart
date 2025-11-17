import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pododoro/utilities.dart' show AddTimerException, Utilities;

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
  late FToast flutterToast;

  @override
  void initState() {
    super.initState();

    flutterToast = FToast();
    flutterToast.init(context);
  }

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
              child: TextField(
                onChanged: (value) => _name = value,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Constants.mainPageComplementTextColor
                ),
              )
            ),
            TimerRow(
              header: "How long to work?",
              child: NewTimer(
                onMinutesChanged: (value) => _workMinutes = int.tryParse(value),
                onSecondsChanged: (value) => _workSeconds = int.tryParse(value),
              ),
            ),
            TimerRow(
              header: "How long to rest?",
              child: NewTimer(
                onMinutesChanged: (value) => _restMinutes = int.tryParse(value),
                onSecondsChanged: (value) => _restSeconds = int.tryParse(value),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var (success, errorMessage) = canAdd();
                  if (!success) {
                    Utilities.showToast(flutterToast, errorMessage);
                    return;
                  }

                  await widget.onAdd(_name!, _workMinutes!, _workSeconds!, _restMinutes!, _restSeconds!);
                } on AddTimerException {
                  if (context.mounted) {
                    Utilities.showToast(flutterToast, "A timer with the name ${_name!} already exists.");
                  }

                  return;
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Add")
            ),
          ],
        ),
      ),
    );
  }

  /// If any input values are invalid, return the error message.
  (bool, String) canAdd() {
    bool success = true;
    List<String> errorMessages = <String>[];

    if (_name == null || _name!.isEmpty) {
      success = false;
      errorMessages.add("Invalid name.");
    }

    if (_workMinutes == null || _workMinutes! < 0 || _workMinutes! > 59 ||
      _workSeconds == null || _workSeconds! < 0 || _workSeconds! > 59 || (_workMinutes! == 0 && _workSeconds! == 0)) {
      success = false;
      errorMessages.add("Invalid work timer.");
    }

    if (_restMinutes == null || _restMinutes! < 0 || _restMinutes! > 59 ||
      _restSeconds == null || _restSeconds! < 0 || _restSeconds! > 59 || (_restMinutes! == 0 && _restSeconds! == 0)) {
      success = false;
      errorMessages.add("Invalid rest timer.");
    }

    return (success, errorMessages.join('\n'));
  }
}

class TimerRow extends StatelessWidget {
  final String header;
  final Widget child;

  const TimerRow({super.key, required this.header, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              header,
              style: const TextStyle(
                color: Constants.mainPageComplementTextColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: child,
        )
      ],
    );
  }
}

class NewTimer extends StatefulWidget {
  final Function(String) onMinutesChanged;
  final Function(String) onSecondsChanged;

  const NewTimer({
    super.key,
    required this.onMinutesChanged,
    required this.onSecondsChanged,
  });

  @override
  State<NewTimer> createState() => _NewTimerState();
}

class _NewTimerState extends State<NewTimer> {
  late FocusNode _minutesFocusNode;
  late FocusNode _secondsFocusNode;

  @override
  void initState() {
    super.initState();

    _minutesFocusNode = FocusNode();
    _secondsFocusNode = FocusNode();

    // Immediately request focus on the minutes box when this widget is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) => _minutesFocusNode.requestFocus());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      InputTimeBox(focusNode: _minutesFocusNode, onTextChanged: _onMinutesChanged,),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: const Text(
          ":",
          style: TextStyle(
            color: Colors.white,
            fontSize: 56,
          ),
        ),
      ),
      InputTimeBox(focusNode: _secondsFocusNode, onTextChanged: _onSecondsChanged,),
    ],
  );
  }

  void _onMinutesChanged(String minutesText) {
    widget.onMinutesChanged(minutesText);

    if (minutesText.length == 2) {
      _secondsFocusNode.requestFocus();
    }
  }

  void _onSecondsChanged(String secondsText) {
    widget.onSecondsChanged(secondsText);
  }
}

class InputTimeBox extends StatelessWidget {
  final FocusNode focusNode;
  final Function(String)? onTextChanged;

  const InputTimeBox({
    super.key,
    required this.focusNode,
    this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextField(
        autofocus: true,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        onChanged: onTextChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 18.0),
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: 56,
        ),
        textAlign: TextAlign.center,
        maxLength: 2,
      ),
    );
  }
}