import 'package:day_targets/src/screens/settings.dart';
import 'package:day_targets/src/screens/targets.dart';
import 'package:flutter/material.dart';

class NavigationBase extends StatefulWidget {
  const NavigationBase({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationBase();
}

class _NavigationBase extends State<NavigationBase> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Targets(),
          Settings(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.golf_course), label: 'Ziele'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Einstellung'),
        ],
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
      )
    );
  }

}