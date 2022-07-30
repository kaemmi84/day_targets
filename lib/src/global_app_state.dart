import 'package:flutter/material.dart';

import 'models/day_target.dart';
import 'models/target.dart';

class GlobalAppState extends InheritedWidget {

  final List<Target> targets;
  final List<DayTarget> dayTargets;

  const GlobalAppState({Key? key,
    required this.targets,
    required this.dayTargets,
    required Widget child,
  }) : super (key: key, child: child);

  @override
  bool updateShouldNotify(GlobalAppState oldWidget) {
    return targets != oldWidget.targets || dayTargets != oldWidget.dayTargets;
  }

}