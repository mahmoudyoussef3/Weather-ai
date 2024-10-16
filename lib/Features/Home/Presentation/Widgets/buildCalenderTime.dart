import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../BuisinessLogic/weather_cubit.dart';

class BuildCalendarTime extends StatefulWidget {
  BuildCalendarTime({super.key, required this.myDateTime});
  String myDateTime;

  @override
  State<BuildCalendarTime> createState() => _BuildCalendarTimeState();
}

class _BuildCalendarTimeState extends State<BuildCalendarTime> {
  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      shrinkHeight: 30,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 2)),
      width: MediaQuery.of(context).size.width / 6,
      onDateSelected: (date) {
        widget.myDateTime = DateFormat('yyyy-MM-dd').format(date);

        context.read<WeatherCubit>().mySelectedDate = widget.myDateTime;
        print(context.read<WeatherCubit>().mySelectedDate);
      },
      leftMargin: 15,
      dayNameFontSize: 14,
      shrinkFontSize: 12,
      shrinkDayNameFontSize: 12,
      monthColor: Colors.blueGrey,
      dayColor: Colors.white,
      activeDayColor: const Color(0xff001739),
      activeBackgroundDayColor: Colors.white,
      dotColor: const Color(0xff001739),
      locale: 'en',
    );
  }
}
