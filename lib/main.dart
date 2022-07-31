import 'package:day_targets/src/global_app_state.dart';
import 'package:day_targets/src/navigation_base.dart';
import 'package:flutter/material.dart';

import 'src/data/database_provider.dart';
import 'src/data/repository/day_target_repository.dart';
import 'src/data/repository/target_repository.dart';
import 'src/models/day_target.dart';
import 'src/models/target.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Target> _targets = [];
  List<DayTarget> _dayTargets = [];

  @override
  Widget build(BuildContext context) {
    return GlobalAppState(
      targets: _targets,
      dayTargets: _dayTargets,
      child: MaterialApp(
        title: 'Day Targets',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: NavigationBase(
          onChange: () {
            _loadTargets();
            _loadDayTargets();
          },
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _loadTargets();
    _loadDayTargets();
  }

  void _loadTargets() {
      var targetRepository = TargetRepository(DatabaseProvider.get);
      targetRepository.getAll().then((results) {
        _targets = results;
        setState(() {});
      });
  }

  void _loadDayTargets() {
      var dayTargetRepository = DayTargetRepository(DatabaseProvider.get);
      dayTargetRepository.getAll().then((results) {
        _dayTargets = results;
        setState(() {});
      });
  }
}
