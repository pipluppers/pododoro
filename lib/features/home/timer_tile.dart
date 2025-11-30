import 'package:flutter/material.dart';

import 'package:pododoro/data_management/database_service.dart' show ITimer;
import 'package:pododoro/constants.dart';
import 'package:pododoro/resources/string_resources.dart';
import 'package:pododoro/utilities.dart';

/// Represents the view for an individual timer in the timer page.
class TimerTile extends StatelessWidget {
  final ITimer timer;
  final Function onTap;
  final Function removeTimer;
  final bool isSelected;
  
  const TimerTile({
    super.key,
    required this.timer,
    required this.onTap,
    required this.removeTimer,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: Constants.timerPadding),
      child: ListTile(
        title: Text(
          timer.name,
          style: const TextStyle(color: Constants.mainPageComplementTextColor,),
        ),
        subtitle: Text(
          Utilities.getTimeUnitDisplay(timer.totalWorkMinutes, timer.totalWorkSeconds),
          style: const TextStyle(color: Constants.mainPageComplementTextColor,),
        ),
        onTap: () => onTap(),
        onLongPress: () => _showContextMenu(context),
        selected: isSelected,
        selectedColor: Colors.orange,
        selectedTileColor: Constants.selectedTimerTileColor,
        tileColor: Constants.mainPageComplementColor,
        leading: Icon(Icons.timelapse),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.timerBorderRadius),
        ),
        style: ListTileStyle.list,
      ),
    );
  }

  /// Displays any context menu options for the timer.
  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(StringResources.delete),
              onTap: () => removeTimer(),
            ),
          ]
        );
      }
    );
  }
}