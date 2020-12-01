import 'package:escol/views/calendar/calendarPage.dart';
import 'package:escol/views/home/homePage.dart';
import 'package:escol/views/horario/horarioPage.dart';
import 'package:escol/views/moreOption/moreOptionPage.dart';
import 'package:escol/views/shared/general/theme/colors.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
    });
  }

  final List<Widget> pagesAluno = [
    HomePage(),
    HorarioPage(),
    CalendarPage(),
    MoreOptionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _bottomItemsAluno = [
      BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 0 ? Icons.home : Icons.home_outlined,
          ),
          label: 'Início'),
      BottomNavigationBarItem(
          icon: Icon(_currentIndex == 1 ? Icons.watch_later : Icons.schedule),
          label: 'Horário'),
      BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today), label: 'Calendário'),
      BottomNavigationBarItem(
          icon: Icon(
            _currentIndex == 3 ? Icons.more_horiz : Icons.more_horiz_outlined,
          ),
          label: 'Mais'),
    ];

    return PageView(
      children: <Widget>[
        Scaffold(
          body: pagesAluno[_currentIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: primary, appBarTheme: AppBarTheme()),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTapped,
              unselectedIconTheme: IconThemeData(color: neutralMid),
              unselectedFontSize: 10,
              selectedFontSize: 10,
              currentIndex: _currentIndex,
              items: _bottomItemsAluno,
              backgroundColor: primary,
              selectedItemColor: secondaryColor,
            ),
          ),
        )
      ],
    );
  }
}
