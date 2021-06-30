import 'dart:convert';

import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_slot_booker/core/core.dart';

import '../core/models/models.dart';

class TimeSlotsProvider extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late List<TimeSlot> _timeSlots;
  late bool _offlineMode;
  late String _errorMessage;
  late TimeSlotState _state;

  @override
  void onInit() {
    //initialize variables
    _timeSlots = [];
    _offlineMode = true;
    _errorMessage = '';
    _state = TimeSlotState.LOADING;

    super.onInit();
  }

  //setters
  set setOfflineMode(bool om) {
    _offlineMode = om;
    update();
    loadAllTimeSlots();
  }

  set setTimeSlotState(TimeSlotState tss) => _state = tss;

  //getters
  get timeSlots => _timeSlots;
  get isOfflineMode => _offlineMode;
  get errorMessage => _errorMessage;
  get state => _state;

  ///[Method for loading all time slots]
  ///
  Future<void> loadAllTimeSlots() async {
    try {
      _state = TimeSlotState.LOADING;
      update();

      //check mode
      if (isOfflineMode) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        //loading data from shared prefs
        _timeSlots = [];
        _timeSlots = List.from(TimeSlot.timeSlots);

        _timeSlots.forEach((slot) {
          if (prefs.containsKey('${slot.id}')) {
            String userString = prefs.getString('${slot.id}')!;

            Map<String, dynamic> userData = json.decode(userString);

            slot.userFirstName = userData['user_first_name'];
            slot.userLastName = userData['user_last_name'];
            slot.userPhoneNumber = userData['user_phone_number'];
          } else {
            slot.userFirstName = null;
            slot.userLastName = null;
            slot.userPhoneNumber = null;
          }
        });

        _state = TimeSlotState.LOADED;
        update();
      } else {
        if (await NetworkInfo.isConnected) {
          _timeSlots = [];
          _timeSlots = List.from(TimeSlot.timeSlots);
          //loading data from firebase
          QuerySnapshot timeSlotsSnapshot =
              await _firestore.collection('time_slots').get();

          List<QueryDocumentSnapshot> timeSlotDocs = timeSlotsSnapshot.docs;

          _timeSlots.forEach((slot) {
            QueryDocumentSnapshot? documentSnapshot =
                timeSlotDocs.firstWhereOrNull(
              (element) => element.id == slot.id.toString(),
            );

            Map<String, dynamic> userData = {};
            if (documentSnapshot != null) {
              userData = documentSnapshot.data() as Map<String, dynamic>;
            }

            slot.userFirstName = userData['user_first_name'] ?? null;
            slot.userLastName = userData['user_last_name'] ?? null;
            slot.userPhoneNumber = userData['user_phone_number'] ?? null;
          });

          _state = TimeSlotState.LOADED;
          update();
        } else {
          _state = TimeSlotState.DEVICE_OFFLINE;
          _errorMessage = 'Device Offline!';
          update();
        }
      }
    } catch (e) {
      _state = TimeSlotState.ERROR;
      _errorMessage = e.toString();
      update();
    }
  }

  ///[Method for booking a slot and populating it with data]
  ///
  Future<bool?> bookSlot(TimeSlot timeSlot) async {
    try {
      Map<String, dynamic> userData = {
        'user_first_name': timeSlot.userFirstName,
        'user_last_name': timeSlot.userLastName,
        'user_phone_number': timeSlot.userPhoneNumber,
      };
      //checking if online or offline mode
      if (isOfflineMode) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        final result = await prefs.setString(
          '${timeSlot.id}',
          json.encode(userData),
        );

        if (result) return true;
        return false;
      } else {
        await _firestore
            .collection('time_slots')
            .doc('${timeSlot.id}')
            .set(userData);

        return true;
      }
    } catch (e) {
      _state = TimeSlotState.ERROR;
      _errorMessage = e.toString();
      update();
    }
  }
}

enum TimeSlotState {
  LOADING,
  LOADED,
  ERROR,
  DEVICE_OFFLINE,
}
