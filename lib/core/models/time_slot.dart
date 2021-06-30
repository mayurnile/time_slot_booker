import 'package:flutter/material.dart';

class TimeSlot {
  final int id;
  final TimeOfDay slotStartTime;
  final TimeOfDay slotEndTime;
  String? userFirstName;
  String? userLastName;
  String? userPhoneNumber;

  TimeSlot({
    required this.id,
    required this.slotStartTime,
    required this.slotEndTime,
    this.userFirstName,
    this.userLastName,
    this.userPhoneNumber,
  });

  factory TimeSlot.fromJSON(Map<String, dynamic> data) {
    return TimeSlot(
      id: data['id'],
      slotStartTime: data['slot_start_time'] ?? 9,
      slotEndTime: data['slot_end_time'] ?? 10,
      userFirstName: data['first_name'],
      userLastName: data['last_name'],
      userPhoneNumber: data['phone_number'],
    );
  }

  static List<TimeSlot> timeSlots = [
    TimeSlot(
      id: 0,
      slotStartTime: TimeOfDay(hour: 9, minute: 0),
      slotEndTime: TimeOfDay(hour: 10, minute: 0),
    ),
    TimeSlot(
      id: 1,
      slotStartTime: TimeOfDay(hour: 10, minute: 0),
      slotEndTime: TimeOfDay(hour: 11, minute: 0),
    ),
    TimeSlot(
      id: 2,
      slotStartTime: TimeOfDay(hour: 11, minute: 0),
      slotEndTime: TimeOfDay(hour: 12, minute: 0),
    ),
    TimeSlot(
      id: 3,
      slotStartTime: TimeOfDay(hour: 12, minute: 0),
      slotEndTime: TimeOfDay(hour: 13, minute: 0),
    ),
    TimeSlot(
      id: 4,
      slotStartTime: TimeOfDay(hour: 13, minute: 0),
      slotEndTime: TimeOfDay(hour: 14, minute: 0),
    ),
    TimeSlot(
      id: 5,
      slotStartTime: TimeOfDay(hour: 14, minute: 0),
      slotEndTime: TimeOfDay(hour: 15, minute: 0),
    ),
    TimeSlot(
      id: 6,
      slotStartTime: TimeOfDay(hour: 15, minute: 0),
      slotEndTime: TimeOfDay(hour: 16, minute: 0),
    ),
    TimeSlot(
      id: 7,
      slotStartTime: TimeOfDay(hour: 16, minute: 0),
      slotEndTime: TimeOfDay(hour: 17, minute: 0),
    ),
  ];
}
