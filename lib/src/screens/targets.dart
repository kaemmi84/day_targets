import 'package:day_targets/src/widgets/app-day-choose-bar.dart';
import 'package:day_targets/src/widgets/target_list_tile.dart';
import 'package:flutter/material.dart';

import '../models/day_target.dart';

class Targets extends StatefulWidget {
  const Targets({Key? key}) : super(key: key);

  @override
  State<Targets> createState() => _Home();
}

class _Home extends State<Targets> {
  List<DayTarget> _targets = [];
  bool _editMode = false;
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDayChooseBar(
        currentDate: _currentDate,
        onChangeDate: (DateTime newDate) {
            setState(() {
              _currentDate = newDate;
            });
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _targets.length,
        itemBuilder: (context, index) =>
          TargetListTile(
          onSubmit: (String value) {},
          editMode:  Mode.show,
          value: _targets[index].target.description,
          target: _targets[index].target,
          labelText: 'Ziel bearbeiten',
          onEditModeChange: (mode, target) {},
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
    // _getTargets();
  }

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }
}