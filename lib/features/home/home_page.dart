import 'package:flutter/material.dart';
import 'package:pododoro/constants.dart' show Constants;
import 'package:pododoro/features/countdown_page/countdown_page.dart';
import 'package:pododoro/features/timer.dart';
import 'package:pododoro/utilities.dart';

class HomePage extends StatefulWidget {
  final Timer? timer;

  const HomePage({super.key, required this.timer});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.defaultBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Utilities.getTimeUnitDisplay(widget.timer?.totalMinutes, widget.timer?.totalSeconds),
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountdownPage(
                    minutes: widget.timer!.totalMinutes!,
                    seconds: widget.timer!.totalSeconds!,
                  ),
                )
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                minimumSize: const Size(200, 200),
                backgroundColor: const Color.fromARGB(255, 238, 24, 9),
              ),
              child: const Text("Start"),
            ),
          ]
        )
      ),
    );
  }
}