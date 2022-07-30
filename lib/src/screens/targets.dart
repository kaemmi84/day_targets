import 'package:day_targets/src/_view_models/shown_target.dart';
import 'package:day_targets/src/widgets/app-day-choose-bar.dart';
import 'package:day_targets/src/widgets/target_list_tile.dart';
import 'package:flutter/material.dart';

class Targets extends StatefulWidget {
  const Targets({Key? key}) : super(key: key);

  @override
  State<Targets> createState() => _Home();
}

class _Home extends State<Targets> {
  List<ShownDayTarget> _targets = [];
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
          editMode: _targets[index].editing ? Mode.edit : Mode.show,
          value: _targets[index].target.description,
          target: _targets[index],
          labelText: 'Ziel bearbeiten',
          onEditModeChange: _disableEditForOtherEntries,
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

  List<TargetListTile> _renderTargets(){
    List<TargetListTile> tiles = _targets.map((target) =>
        TargetListTile(
          onSubmit: (String value) {},
          editMode: target.editing ? Mode.edit : Mode.show,
          value: target.target.description,
          target: target,
          labelText: 'Ziel bearbeiten',
          onEditModeChange: _disableEditForOtherEntries,
        ),
    ).toList();
    // tiles.add(
    //     TargetListTile(
    //         onSubmit: (String value) async {_addNewTarget(value);},
    //         editMode: Mode.create,
    //         value: '',
    //         labelText: 'Neues Ziel hinzufügen'
    //     ),
    // );
    return tiles;
  }

  void _disableEditForOtherEntries(
      Mode mode,
      ShownDayTarget target
  ) {
    print(target);
    setState(() {
      _targets = _targets
          .map((t) {
            print(t.target == target.target && t.day == target.day);
            return ShownDayTarget(
                t.day,
                t.target,
                t.isDone,
                t.target == target.target && t.day == target.day
            );
          }).toList();
      print(_targets);
    });
  }
}