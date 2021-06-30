import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class TimeSlotDetailsScreen extends StatefulWidget {
  final TimeSlot timeSlot;

  const TimeSlotDetailsScreen({
    Key? key,
    required this.timeSlot,
  }) : super(key: key);

  @override
  _TimeSlotDetailsScreenState createState() => _TimeSlotDetailsScreenState();
}

class _TimeSlotDetailsScreenState extends State<TimeSlotDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _userFirstName = '';
  String _userLastName = '';
  String _phoneNumber = '';

  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Time Slot Details',
            style: textTheme.headline1,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //time slot time
              _buildTimeSlotData(),
              //form for data input
              _buildFormInput(),
            ],
          ),
        ),
      ),
    );
  }

  ///[Returns Time - Slot time Header]
  Widget _buildTimeSlotData() {
    DateTime tempStartDate = DateFormat("hh:mm").parse(
        widget.timeSlot.slotStartTime.hour.toString() +
            ":" +
            widget.timeSlot.slotStartTime.minute.toString());
    DateTime tempEndDate = DateFormat("hh:mm").parse(
        widget.timeSlot.slotEndTime.hour.toString() +
            ":" +
            widget.timeSlot.slotEndTime.minute.toString());
    var timeFormat = DateFormat("h:mm a");

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22.0,
        vertical: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            'Time Slot',
            style: textTheme.headline3,
          ),
          //time
          Text(
            '${timeFormat.format(tempStartDate)} - ${timeFormat.format(tempEndDate)}',
            style: textTheme.headline3,
          ),
        ],
      ),
    );
  }

  ///[Form for taking user details as input]
  ///
  Widget _buildFormInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //spacing
            SizedBox(height: 12.0),
            //first name input
            TextFormField(
              initialValue: widget.timeSlot.userFirstName,
              style: textTheme.headline4,
              decoration: InputDecoration(
                labelText: 'Enter First Name',
                labelStyle: textTheme.headline3,
              ),
              onSaved: (String? value) => _userFirstName = value ?? '',
              validator: (String? value) {
                if (value != null && value.length == 0) {
                  return 'This field cannot be empty!';
                }
              },
            ),
            //spacing
            SizedBox(height: 22.0),
            //first name input
            TextFormField(
              initialValue: widget.timeSlot.userLastName,
              style: textTheme.headline4,
              decoration: InputDecoration(
                labelText: 'Enter Last Name',
                labelStyle: textTheme.headline3,
              ),
              onSaved: (String? value) => _userLastName = value ?? '',
              validator: (String? value) {
                if (value != null && value.length == 0) {
                  return 'This field cannot be empty!';
                }
              },
            ),
            //spacing
            SizedBox(height: 22.0),
            //first name input
            TextFormField(
              initialValue: widget.timeSlot.userPhoneNumber,
              style: textTheme.headline4,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                labelStyle: textTheme.headline3,
              ),
              onSaved: (String? value) => _phoneNumber = value ?? '',
              validator: (String? value) {
                if (value != null && value.length == 0) {
                  return 'This field cannot be empty!';
                }
              },
            ),
            //spacing
            SizedBox(height: 42.0),
            //actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //cancel button
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: OutlinedButton(
                    onPressed: () =>
                        locator.get<NavigationService>().navigateBack(),
                    style: OutlinedButton.styleFrom(
                      elevation: 0.0,
                      primary: TimeSlotBookerTheme.PRIMARY_COLOR,
                      side: BorderSide(
                        color: TimeSlotBookerTheme.PRIMARY_COLOR,
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 22.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: textTheme.headline3!.copyWith(
                        color: TimeSlotBookerTheme.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
                //spacing
                SizedBox(width: 8.0),
                //save button
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    onPressed: _bookSlot,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: TimeSlotBookerTheme.PRIMARY_COLOR,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 22.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _bookSlot() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      widget.timeSlot.userFirstName = _userFirstName;
      widget.timeSlot.userLastName = _userLastName;
      widget.timeSlot.userPhoneNumber = _phoneNumber;

      TimeSlotsProvider _timeSlotProvider = locator.get<TimeSlotsProvider>();

      final result = await _timeSlotProvider.bookSlot(widget.timeSlot);

      if (result != null && result) {
        _timeSlotProvider.loadAllTimeSlots();
        Fluttertoast.showToast(msg: 'Slot Booked!');
        locator.get<NavigationService>().navigateBack();
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong...');
      }
    }
  }
}
