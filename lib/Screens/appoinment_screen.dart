import 'package:beginapp01/OOP_material/appoinment.dart';
import 'package:beginapp01/Screens/main_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:beginapp01/const_color.dart';
import 'package:flutter/material.dart';
import 'package:beginapp01/ultis.dart';

class AppoinmentScreen extends StatefulWidget {
  static String routeName = 'AppointmentScreen';

  @override
  State<AppoinmentScreen> createState() => _AppoinmentScreenState();
}

class _AppoinmentScreenState extends State<AppoinmentScreen> {
  //METHOD CỦA APPOINTMENT
  Future<void> _pickDate(Appoinment appoinment) async {
    DateTime? pickedDate = await showDatePicker(
      helpText: 'Ngày đã chọn',
      context: context,
      initialDate: appoinment.dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      cancelText: 'Hủy',
      builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: DialogTheme(
            backgroundColor: Colors.green.shade50, // Màu nền
          ),
        ),
        child: child!,
      );
    },    );

    if (pickedDate != null) {
      setState(() {
        kAppointments[appoinment.dateTime]?.removeWhere( (element) => element.appoinmentID == appoinment.appoinmentID);
        appoinment.dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          appoinment.dateTime.hour,
          appoinment.dateTime.minute,
        );
        if( kAppointments[DateTime( appoinment.dateTime.year, appoinment.dateTime.month, appoinment.dateTime.day )] == null ){
          kAppointments[DateTime( appoinment.dateTime.year, appoinment.dateTime.month, appoinment.dateTime.day )] = [];
        }
        kAppointments[DateTime( appoinment.dateTime.year, appoinment.dateTime.month, appoinment.dateTime.day )]?.add(appoinment);
      });
    }
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AppoinmentScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  Future<void> _pickTime(Appoinment appoinment) async {
    TimeOfDay? pickedTime = await showTimePicker(
      cancelText: 'Hủy',
      context: context,
      initialTime: TimeOfDay.fromDateTime(appoinment.dateTime),
    );

    if (pickedTime != null) {
      setState(() {
        appoinment.dateTime = DateTime(
          appoinment.dateTime.year,
          appoinment.dateTime.month,
          appoinment.dateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
  void changeAnAppoinment(Appoinment appoinment){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteGreenBackground,
          content: Container(
            width: MediaQuery.of(context).size.width*0.125,
            height: MediaQuery.of(context).size.height*0.125,
            child: StatefulBuilder(
              builder: (context,setState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: 
                      Text(
                        '${appoinment.dateTime.hour}'.padLeft(2,'0') +' : ' +'${appoinment.dateTime.minute}'.padLeft(2,'0'),
                        style: TextStyle( fontSize: 25 ),
                      )
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.pressed)) {
                                  return lightGreenBackground; // Khi nhấn
                                } else if (states.contains(WidgetState.disabled)) {
                                  return Colors.grey; // Khi tắt
                                }
                                return lightGreenBackground; // Mặc định
                              }),
                            ),
                            onPressed: (){
                              //Navigator.pushNamed(context, AppoinmentScreen.routeName);
                              _pickDate(appoinment);
                              _pickTime(appoinment);
                            } ,
                            child: const Text("Chỉnh sửa thời gian", style: TextStyle(color: textBlackColor),),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
            ),
          )
        );
      }
    );
  }
  late final ValueNotifier<List<Appoinment>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  /// Lấy danh sách các cuộc hẹn cho một ngày cụ thể
  List<Appoinment> _getEventsForDay(DateTime day) {
    return kAppointments[day] ?? [];
  }

  /// Lấy danh sách các cuộc hẹn trong một khoảng ngày
  List<Appoinment> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  /// Xử lý khi một ngày được chọn
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  /// Xử lý khi một khoảng ngày được chọn
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 0) {
                Navigator.pushNamed(context, MainScreen.routeName);
              }
            },
            backgroundColor: lightGreenBackground,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.arrow_circle_left_outlined),
                selectedIcon: Icon(Icons.arrow_circle_left_outlined),
                label: Text('Quay lại'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                selectedIcon: Icon(Icons.person),
                label: Text('Hồ sơ'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Cài đặt'),
              ),
            ],
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              children: [
                TableCalendar<Appoinment>(
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    weekendStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    dowTextFormatter: (date, locale) {
                      const daysInVietnamese = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                      return daysInVietnamese[date.weekday - 1];
                    },
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    decoration: BoxDecoration(
                      color: lightGreenBackground,
                      borderRadius: BorderRadius.circular(defaultPadding * 3),
                    ),
                    titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    titleTextFormatter: (date, locale) {
                      const monthsInVietnamese = [
                        'Tháng Một',
                        'Tháng Hai',
                        'Tháng Ba',
                        'Tháng Tư',
                        'Tháng Năm',
                        'Tháng Sáu',
                        'Tháng Bảy',
                        'Tháng Tám',
                        'Tháng Chín',
                        'Tháng Mười',
                        'Tháng Mười Một',
                        'Tháng Mười Hai',
                      ];
                      return monthsInVietnamese[date.month - 1];
                    },
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                    ),
                    defaultDecoration: BoxDecoration(
                      color: lightGreenBackground,
                      shape: BoxShape.circle,
                    ),
                    weekendDecoration: BoxDecoration(
                      color: weekendColor,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Appoinment>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: lightGreenBackground,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    onTap: () => print('${value[index]}'),
                                    title: Text('${value[index]}'),
                                  ),
                                ),
                                //const Spacer(),
                                Expanded(
                                  child: ListTile( 
                                    title: Text('${value[index].dateTime.hour}'.padLeft(2,'0') + ' : ' +
                                    '${value[index].dateTime.minute}'.padLeft(2,'0')),
                                   )
                                ),
                                //const Spacer(),
                                IconButton(
                                  onPressed: () => changeAnAppoinment(value[index]), 
                                  icon: const Icon(Icons.edit_calendar)
                                )
                              ],
                            )
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding),
        ],
      ),
    );
  }
}
