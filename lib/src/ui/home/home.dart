import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  DateTime _currentDate = DateTime.now();
  List<DayTarget> _targets = [];
  bool _editMode = false;

  void _toogleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  void _goDayBack() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: -1));
    });
  }

  void _goDayForward() {
    setState(() {
      _currentDate = _currentDate.add(const Duration(days: 1));
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

  List<Column> _renderTargets(){
    List<Column> columns = _targets.map((e) => Column(
        children: [
          ListTile(
            title: Text(e.target.description),
            trailing: IconButton(
              icon: const Icon(Icons.check_sharp),
              onPressed: () {},
            ),
          ),
          const Divider(),
        ]),
    ).toList();
    columns.add(
        Column(
            children: [
              ListTile(
                title: _editMode
                    ? TextField(
                    obscureText: false,
                    autofocus: true,
                    onSubmitted: (String value) {_addNewTarget(value);},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Neues Ziel hinzufügen'
                    )
                )
                    : const Text(''),
                onTap: _toogleEditMode,
              ),
              const Divider(),
            ])
    );
    return columns;
  }

  String _getMonth() {
    switch(_currentDate.month) {
      case 1:
        return 'Januar';
      case 2:
        return 'Februar';
      case 3:
        return 'März';
      case 4:
        return 'April';
      case 5:
        return 'Mai';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Dezember';
      default:
        return _currentDate.month.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _getTargets();
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: _goDayBack,
              tooltip: 'vorheriger Tag',
            ), IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {},
              tooltip: 'Kalendersicht',
            ), IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: _goDayForward,
              tooltip: 'nächster Tag',
            )
          ],
          title:
          Text('${_currentDate.day}. ${_getMonth()} ${_currentDate.year}')
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _renderTargets(),
      ),
      floatingActionButton: _editMode ? null : FloatingActionButton(
        onPressed:_toogleEditMode,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addNewTarget(String value) async {
    if(value.isNotEmpty) {
      print(value);
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
      _toogleEditMode();
    }
  }


}