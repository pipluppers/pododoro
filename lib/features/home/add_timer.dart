import 'package:flutter/material.dart';
import 'package:pododoro/features/home/timer_row.dart';
import 'package:isar/isar.dart' show IsarError;
import 'package:fluttertoast/fluttertoast.dart';

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
              onPressed: () async {
                try {
                  var (success, errorMessage) = canAdd();
                  if (!success) {
                    flutterToast.showToast(
                      child: AddTimerToast(exceptionMessage: errorMessage),
                      toastDuration: Duration(seconds: 2),
                      gravity: ToastGravity.BOTTOM
                    );

                    return;
                  }

                  await widget.onAdd(_name!, _workMinutes!, _workSeconds!, _restMinutes!, _restSeconds!);
                } on IsarError catch (ex) {
                  if (context.mounted) {
                    String exceptionMessage = ex.message == "Unique index violated" ? "A timer with the name ${_name!} already exists." : ex.message;

                    flutterToast.showToast(
                      child: AddTimerToast(exceptionMessage: exceptionMessage),
                      toastDuration: Duration(seconds: 2),
                      gravity: ToastGravity.BOTTOM
                    );
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

class AddTimerToast extends StatelessWidget {
  const AddTimerToast({
    super.key,
    required this.exceptionMessage,
  });

  final String exceptionMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadiusGeometry.all(Radius.elliptical(45, 45)),
      ),
      child: Text(exceptionMessage),
    );
  }
}