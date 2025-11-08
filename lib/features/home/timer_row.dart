import 'package:flutter/material.dart';

class TimerRow extends StatefulWidget {
  final String header;
  final Function(String) onTextChanged;
  final TextInputType textInputType;

  const TimerRow({super.key, required this.header, this.textInputType = TextInputType.text, required this.onTextChanged});

  @override
  State<TimerRow> createState() => _TimerRowState();
}

class _TimerRowState extends State<TimerRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              widget.header,
              style: TextStyle(color: Colors.white)
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              right: 5.0,
              bottom: 5.0
            ),
            child: TextField(
              onChanged: widget.onTextChanged,
              keyboardType: widget.textInputType,
              autofocus: true,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
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
    );
  }
}