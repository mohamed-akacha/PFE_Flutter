/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pfe_flutter/data/model/inspection.dart';
import 'package:pfe_flutter/linkapi.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;



class CalanderPage111 extends StatefulWidget {
  const CalanderPage111({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<CustomAgenda> {
  final List<Appointment> _appointmentDetails = <Appointment>[];

  late _DataSource dataSource;

  @override
  void initState() {
    super.initState();
    getCalendarDataSource().then((value) => dataSource = value);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: dataSource,
                initialSelectedDate: DateTime.now().add(const Duration(days: -1)),
                onSelectionChanged: selectionChanged,
              ),
            ),
            Expanded(
                child: Container(
                    color: Colors.black12,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(2),
                      itemCount: _appointmentDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.all(2),
                            height: 60,
                            color: _appointmentDetails[index].color,
                            child: ListTile(
                              leading: Column(
                                children: <Widget>[
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                        : DateFormat('hh:mm a').format(
                                        _appointmentDetails[index].startTime),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        height: 1.5),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? 'All day'
                                        : '',
                                    style: const TextStyle(
                                        height: 0.5, color: Colors.white),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                        : DateFormat('hh:mm a').format(
                                        _appointmentDetails[index].endTime),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                  child: Icon(
                                    getIcon(_appointmentDetails[index].subject),
                                    size: 30,
                                    color: Colors.white,
                                  )),
                              title: Container(
                                  child: Text(
                                      '${_appointmentDetails[index].subject}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white))),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 5,
                      ),
                    )))
          ],
        ),
      ),
    ));
  }

  void selectionChanged(CalendarSelectionDetails calendarSelectionDetails) {
    getSelectedDateAppointments(calendarSelectionDetails.date);
  }

  void getSelectedDateAppointments(DateTime? selectedDate) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _appointmentDetails.clear();
      });

      if (dataSource.appointments!.isEmpty) {
        return;
      }

      for (int i = 0; i < dataSource.appointments!.length; i++) {
        Appointment appointment = dataSource.appointments![i] as Appointment;
        /// It return the occurrence appointment for the given pattern appointment at the selected date.
        final Appointment? occurrenceAppointment = dataSource.getOccurrenceAppointment(appointment, selectedDate!, '');
        if ((DateTime(appointment.startTime.year, appointment.startTime.month,
            appointment.startTime.day) == DateTime(selectedDate.year,selectedDate.month,
            selectedDate.day)) || occurrenceAppointment != null) {
          setState(() {
            _appointmentDetails.add(appointment);
          });
        }
      }
    });
  }

  Future<_DataSource> getCalendarDataSource() async {
    final response = await http.get(AppLink.inspection as Uri);

    if (response.statusCode == 200) {
      final List<dynamic> inspectionJson = jsonDecode(response.body);
      final List<Inspection> inspections = inspectionJson.map((json) => Inspection.fromJson(json)).toList();

      final List<Appointment> appointments = inspections.map((inspection) => Appointment(
        startTime: inspection.datePrevue,
        endTime: inspection.datePrevue.add(const Duration(hours: 1)), // Ajuster comme nécessaire
        subject: inspection.description,
        color: inspection.statut ? Colors.green : Colors.red, // Changer la couleur en fonction du statut
      )).toList();

      return _DataSource(appointments);
    } else {
      throw Exception('Failed to load inspections from API');
    }
  }

//---------------------------------------------------------------
  IconData getIcon(String subject) {
    if (subject == 'Planning') {
      return Icons.subject;
    } else if (subject == 'Development Meeting   New York, U.S.A') {
      return Icons.people;
    } else if (subject == 'Support - Web Meeting   Dubai, UAE') {
      return Icons.settings;
    } else if (subject == 'Project Plan Meeting   Kuala Lumpur, Malaysia') {
      return Icons.check_circle_outline;
    } else if (subject == 'Retrospective') {
      return Icons.people_outline;
    } else if (subject == 'Project Release Meeting   Istanbul, Turkey') {
      return Icons.people_outline;
    } else if (subject == 'Customer Meeting   Tokyo, Japan') {
      return Icons.settings_phone;
    } else if (subject == 'Release Meeting') {
      return Icons.view_day;
    } else {
      return Icons.beach_access;
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}*/
