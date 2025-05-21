import 'package:bloc/bloc.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_event.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<LoadCalendar>(_onLoadCalendar);
  }

  void _onLoadCalendar(LoadCalendar event, Emitter<CalendarState> emit) {
    DateTime now = DateTime.now();
    int currentDay = now.day;

    List<Map<String, dynamic>> days = [];
    DateTime startOfWeek =
        now.subtract(Duration(days: now.weekday - 1)); // Bắt đầu từ Thứ Hai
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      days.add({
        'date': day.day,
        'day': _getDayName(day.weekday),
      });
    }
    emit(CalendarLoaded(days, currentDay));
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
