import 'package:day_targets/src/data/database_provider.dart';
import 'package:day_targets/src/data/repository/day_target_repository.dart';
import 'package:day_targets/src/models/day_target.dart';
import 'package:day_targets/src/widgets/app_day_choose_bar.dart';
import 'package:flutter/material.dart';

import '../global_app_state.dart';

class Targets extends StatefulWidget {
  const Targets({Key? key}) : super(key: key);

  @override
  State<Targets> createState() => _Targets();
}

class _Targets extends State<Targets> {
  late DateTime _currentDate;

  @override
  Widget build(BuildContext context) {
    final dayTargets = GlobalAppState.of(context)
        .dayTargets
        .where((dayTarget) => dayTarget.date.isAtSameMomentAs(_currentDate))
        .toList();
    _createDayTargetIfNecessary();
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
            itemCount: dayTargets.length,
            itemBuilder: (context, index) {
              var dayTarget = dayTargets[index];
              return ListTile(
                title: Text(dayTarget.target.description),
                trailing: IconButton(
                  icon: const Icon(Icons.check_sharp),
                  color: dayTarget.isDone ? Colors.green : null,
                  onPressed: () {
                    _toggleCheckStateTarget(dayTarget);
                  },
                ),
              );
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _createDayTargetIfNecessary();
  }


  _toggleCheckStateTarget(DayTarget dayTarget) {
    dayTarget.isDone = !dayTarget.isDone;
    DayTargetRepository(DatabaseProvider.get)
        .update(dayTarget)
        .then((value) => setState(() {}));
  }

  void _createDayTargetIfNecessary() {
    for (var target in GlobalAppState.of(context).targets) {
      var dayTargets = GlobalAppState.of(context).dayTargets;
      var currentDayTargets = dayTargets.where((dayTarget) {
        return dayTarget.target == target
            && dayTarget.date.isAtSameMomentAs(_currentDate);
      });
      if (currentDayTargets.isEmpty) {
        DayTargetRepository(DatabaseProvider.get)
            .insert(DayTarget(target, _currentDate))
            .then((dt) {
          setState(() {
            dayTargets.add(dt);
          });
        });
      } else {
        setState(() {});
      }
    }
  }
}
