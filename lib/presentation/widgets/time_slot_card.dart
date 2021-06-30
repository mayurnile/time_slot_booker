import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../di/locator.dart';

class TimeSlotCard extends StatelessWidget {
  final TimeSlot timeSlot;

  TimeSlotCard({
    Key? key,
    required this.timeSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    DateTime tempStartDate = DateFormat("hh:mm").parse(
        timeSlot.slotStartTime.hour.toString() +
            ":" +
            timeSlot.slotStartTime.minute.toString());
    DateTime tempEndDate = DateFormat("hh:mm").parse(
        timeSlot.slotEndTime.hour.toString() +
            ":" +
            timeSlot.slotEndTime.minute.toString());
    var timeFormat = DateFormat("h:mm a");

    bool isBooked = timeSlot.userFirstName != null;

    return InkWell(
      onTap: () => locator.get<NavigationService>().navigateToNamed(
        TIME_SLOT_DETAILS_ROUTE,
        arguments: {
          'time_slot': timeSlot,
        },
      ),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: isBooked
              ? TimeSlotBookerTheme.BOOKED_SLOT_COLOR
              : TimeSlotBookerTheme.PRIMARY_COLOR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //name
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Slot',
                  style: textTheme.headline3!.copyWith(color: Colors.white),
                ),
                //book or not booked
                if (isBooked)
                  Text(
                    'Booked',
                    style: textTheme.headline5!.copyWith(color: Colors.white),
                  ),
              ],
            ),
            // slot time
            Text(
              '${timeFormat.format(tempStartDate)} - ${timeFormat.format(tempEndDate)}',
              style: textTheme.headline3!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
