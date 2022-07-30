import 'package:day_targets/src/data/database_provider.dart';
import 'package:day_targets/src/data/repository/day_target_repository.dart';
import 'package:day_targets/src/data/repository/target_repository.dart';
import 'package:day_targets/src/models/target.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../global_app_state.dart';
import 'target_create.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    final targets = context.dependOnInheritedWidgetOfExactType<GlobalAppState>()!.targets;
    return Scaffold(
        appBar: AppBar(
            title: const Text('Ziele definieren'),
          ),
        body: targets.isEmpty ? const Center(
              child: Text('Noch keine Ziele hinterlegt'),
          ) : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: targets.length,
                itemBuilder: (context, index) {
                  final target = targets[index];
                  return Slidable(
                    key: UniqueKey(),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      dismissible: DismissiblePane(
                          onDismissed: () => _deleteTarget(target, targets)
                      ),
                      children: [
                        SlidableAction(
                          onPressed: (context) => _deleteTarget(target, targets),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Löschen',
                        )
                      ],
                    ),
                    child: ListTile(
                      title: Text(target.description),
                    ),
                  );
                }
              ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_target_btn',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TargetCreate()),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _deleteTarget(Target target, List<Target> targets) {
      if(target.id != null) {
        DayTargetRepository(DatabaseProvider.get).deleteDayTargetByTargetId(target.id!)
            .then((value) {
          TargetRepository(DatabaseProvider.get)
              .delete(target)
              .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Ziel ${target.description} wurde für alle Tage gelöscht')
                      )
                  );
                  setState(() {
                    targets.remove(value);
                  });
          });
        });
      }
  }
}