abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<Map<String, dynamic>> days;
  final int currentDay;
  CalendarLoaded(this.days, this.currentDay);
}
