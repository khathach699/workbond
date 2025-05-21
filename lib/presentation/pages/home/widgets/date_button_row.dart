// lib/presentation/widgets/date_button_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_state.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_bloc.dart';
import 'package:workbond/presentation/pages/home/widgets/custom_date_button.dart';

class DateButtonRow extends StatelessWidget {
  final Responsive responsive;

  const DateButtonRow({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.days.map((day) {
                return DateButton(
                  date: day['date'],
                  day: day['day'],
                  isToday: day['date'] == state.currentDay,
                  responsive: responsive,
                );
              }).toList(),
            ),
          );
        }
        // if (state is CalendarLoading) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        // if (state is CalendarError) {
        //   return const Center(child: Text('Error loading calendar'));
        // }
        return const SizedBox.shrink();
      },
    );
  }
}
