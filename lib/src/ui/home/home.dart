import 'package:day_targets/src/widgets/app-day-choose-bar.dart';
import 'package:day_targets/src/widgets/app_editable_list_tile.dart';
import 'package:flutter/material.dart';

import '../../data/database_provider.dart';
import '../../data/repository/day_repository.dart';
import '../../data/repository/day_target_repository.dart';
import '../../data/repository/target_repository.dart';
import '../../models/day.dart';
import '../../models/day_target.dart';
import '../../models/target.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<DayTarget> _targets = [];
  bool _editMode = false;
  DateTime _currentDate = DateTime.now();

  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  void _getTargets()  {
    setState(() {
      var dayTargetRepository = DayTargetRepository(DatabaseProvider.get);
      dayTargetRepository.getAll().then((value) => {
        _targets = value
      });
    });
  }

  List<AppEditableListTile> _renderTargets(){
    List<AppEditableListTile> tiles = _targets.map((e) =>
        AppEditableListTile(
            onSubmit: (String value) {},
            editMode: false,
            value: e.target.description,
            labelText: 'Ziel bearbeiten'
        ),
    ).toList();
    tiles.add(
        AppEditableListTile(
            onSubmit: (String value) async {_addNewTarget(value);},
            editMode: _editMode,
            value: '',
            labelText: 'Neues Ziel hinzufügen'
        ),
    );
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    _getTargets();
    return Scaffold(
      appBar: AppDayChooseBar(
        currentDate: _currentDate,
        onChangeDate: (DateTime newDate) {
            setState(() {
              _currentDate = newDate;
            });
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _renderTargets(),
      ),
      floatingActionButton: _editMode ? null : FloatingActionButton(
        onPressed:_toggleEditMode,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addNewTarget(String value) async {
    if(value.isNotEmpty) {
      var dayRepository = DayRepository(DatabaseProvider.get);
      var targetRepository = TargetRepository(DatabaseProvider.get);
      var dayTargetRepository = DayTargetRepository(DatabaseProvider.get);

      var target = Target(null, value);
      await targetRepository.insert(target);

      var day = Day(null, _currentDate);
      await dayRepository.insert(day);

      var dayTarget = DayTarget(day, target, isDone: true);
      await dayTargetRepository.insert(dayTarget);
      _getTargets();
      // _toggleEditMode();
    }
  }
}