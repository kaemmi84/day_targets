import 'package:flutter/material.dart';

class AppDayChooseBar extends StatelessWidget implements PreferredSizeWidget {
  DateTime currentDate;
  final double height;
  final Function(DateTime newDate) onChangeDate;

  AppDayChooseBar({
    Key? key,
    required this.currentDate,
    this.height = kToolbarHeight,
    required this.onChangeDate,
  }) : super(key: key);

  // @override
  // State<AppDayChooseBar> createState() => _AppDayChooseBar();

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    var actions = [
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
        onPressed: currentDate.isBefore(_getToday()) ? _goDayForward : null,
        tooltip: currentDate.isBefore(_getToday()) ? 'nächster Tag' : 'Nur aktuelle Ziele sind einstellbar',
      )
    ];

    return AppBar(
        actions: actions,
        title:
        Text('${currentDate.day}. ${_getMonth()} ${currentDate.year}')
    );
  }

  void _goDayBack() {
    currentDate = currentDate.add(const Duration(days: -1));
    onChangeDate.call(currentDate);
  }

  void _goDayForward() {
    currentDate = currentDate.add(const Duration(days: 1));
    onChangeDate.call(currentDate);
  }

  String _getMonth() {
    switch (currentDate.month) {
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
        return currentDate.month.toString();
    }
  }

  DateTime _getToday() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}