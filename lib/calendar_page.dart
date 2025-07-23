import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  void _addEvent() {
    if (_selectedDay == null) return;
    TextEditingController eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Event"),
        content: TextField(
          controller: eventController,
          decoration: const InputDecoration(hintText: "Enter event details"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                if (_events[_selectedDay!] == null) {
                  _events[_selectedDay!] = [];
                }
                _events[_selectedDay!]!.add(eventController.text);
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editEvent(int index) {
    if (_selectedDay == null) return;
    TextEditingController eventController = TextEditingController(text: _events[_selectedDay!]![index]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Event"),
        content: TextField(
          controller: eventController,
          decoration: const InputDecoration(hintText: "Edit event details"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _events[_selectedDay!]![index] = eventController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(int index) {
    if (_selectedDay == null) return;
    setState(() {
      _events[_selectedDay!]!.removeAt(index);
      if (_events[_selectedDay!]!.isEmpty) {
        _events.remove(_selectedDay!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Calendar'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            headerStyle: const HeaderStyle(formatButtonVisible: true),
          ),
          const SizedBox(height: 20),
          _selectedDay != null
              ? Column(
            children: [
              Text(
                'Selected Date: ${_selectedDay.toString().split(' ')[0]}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addEvent,
                child: const Text("Add Event"),
              ),
              ...?_events[_selectedDay]?.asMap().entries.map(
                    (entry) => ListTile(
                  title: Text(entry.value),
                  leading: const Icon(Icons.event),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editEvent(entry.key),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEvent(entry.key),
                      ),
                    ],
                  ),
                ),
              ) ?? [],
            ],
          )
              : const Text(
            'Select a date to view events',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}






















