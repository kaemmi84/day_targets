import 'package:day_targets/src/data/database_provider.dart';
import 'package:day_targets/src/data/repository/target_repository.dart';
import 'package:day_targets/src/global_app_state.dart';
import 'package:day_targets/src/models/target.dart';
import 'package:flutter/material.dart';

class TargetCreate extends StatefulWidget {
  const TargetCreate({Key? key}) : super(key: key);

  @override
  State<TargetCreate> createState() => _TargetCreate();
}

class _TargetCreate extends State<TargetCreate> {
  final TextEditingController _targetDescriptionController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neues Ziel definieren'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _targetDescriptionController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Neues Ziel',
                helperText: 'Definiere ein neues tägliches Ziel',
                prefixIcon: Icon(Icons.golf_course),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTarget = Target(_targetDescriptionController.text);
                TargetRepository(DatabaseProvider.get)
                    .insert(newTarget)
                    .then((value) {
                      context.dependOnInheritedWidgetOfExactType<GlobalAppState>()!.targets.add(newTarget);
                      Navigator.pop(context);
                    });
              },
              child: Text('Ziel hinzufügen'),
            ),
          ],
        ),
      ),
    );
  }
}