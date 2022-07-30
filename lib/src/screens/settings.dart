import 'package:day_targets/src/data/database_provider.dart';
import 'package:day_targets/src/data/repository/day_target_repository.dart';
import 'package:day_targets/src/data/repository/target_repository.dart';
import 'package:day_targets/src/models/target.dart';
import 'package:day_targets/src/widgets/list_item.dart';
import 'package:flutter/material.dart';

import '../global_app_state.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final targets =
        context.dependOnInheritedWidgetOfExactType<GlobalAppState>()!.targets;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ziele definieren'),
      ),
      body: targets.isEmpty
          ? const Center(
              child: Text('Noch keine Ziele hinterlegt'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: targets.length + 1,
              itemBuilder: (context, index) {
                if (index == targets.length) {
                  var controller = TextEditingController(text: '');
                  return ListItem(
                      controller: controller,
                      hintText: 'Neues Ziel hinzufügen',
                      onEditingComplete: () {
                        addNewTarget(controller, targets);
                      });
                }

                final target = targets[index];
                var editController =
                    TextEditingController(text: target.description);
                return ListItem(
                  controller: editController,
                  onDeleteClick: (context) {
                    _deleteTarget(target, targets);
                  },
                  onDeleteSlide: () {
                    _deleteTarget(target, targets);
                  },
                );
              }),
    );
  }

  void addNewTarget(TextEditingController controller, List<Target> targets) {
    if (controller.text.isNotEmpty) {
      Target newTarget = Target(controller.text);
      TargetRepository(DatabaseProvider.get).insert(newTarget).then((result) {
        setState(() {
          targets.add(result);
        });
      });
    }
  }

  void _deleteTarget(Target target, List<Target> targets) {
    if (target.id != null) {
      DayTargetRepository(DatabaseProvider.get)
          .deleteDayTargetByTargetId(target.id!)
          .then((value) {
        TargetRepository(DatabaseProvider.get).delete(target).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Ziel ${target.description} wurde für alle Tage gelöscht')));
          setState(() {
            targets.remove(value);
          });
        });
      });
    }
  }
}
