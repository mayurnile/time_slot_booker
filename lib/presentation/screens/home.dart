import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../../core/core.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Time Slot Booker',
          style: textTheme.headline1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: GetBuilder<TimeSlotsProvider>(
          initState: (_) {
            TimeSlotsProvider timeSlotsProvider = Get.find();
            timeSlotsProvider.loadAllTimeSlots();
          },
          builder: (
            TimeSlotsProvider _timeSlotsProvider,
          ) {
            switch (_timeSlotsProvider.state) {
              case TimeSlotState.LOADING:
                return _buildLoadingIndicator();
              case TimeSlotState.DEVICE_OFFLINE:
                return _buildOfflineErrorMessage(
                  _timeSlotsProvider,
                  textTheme,
                );
              case TimeSlotState.ERROR:
                return _buildErrorMessage(_timeSlotsProvider.errorMessage);
              case TimeSlotState.LOADED:
                return _buildTimeSlotsList(_timeSlotsProvider, textTheme);
              default:
                return _buildLoadingIndicator();
            }
          },
        ),
      ),
    );
  }

  ///[List of all time slots]
  Widget _buildTimeSlotsList(
    TimeSlotsProvider _timeSlotsProvider,
    TextTheme textTheme,
  ) {
    return RefreshIndicator(
      onRefresh: () => _timeSlotsProvider.loadAllTimeSlots(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //mode changing switch
          _buildModeChangingSwitch(_timeSlotsProvider, textTheme),
          //list of time slots
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _timeSlotsProvider.timeSlots.length,
              itemBuilder: (BuildContext ctx, int index) {
                TimeSlot timeSlot = _timeSlotsProvider.timeSlots[index];

                return TimeSlotCard(timeSlot: timeSlot);
              },
            ),
          ),
        ],
      ),
    );
  }

  ///[Widget for changing mode]
  Widget _buildModeChangingSwitch(
    TimeSlotsProvider _timeSlotsProvider,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            'Mode',
            style: textTheme.headline2,
          ),
          //spacing
          Spacer(),
          //text
          Text(
            _timeSlotsProvider.isOfflineMode ? 'Offline' : 'Online',
            style: textTheme.headline2,
          ),
          //switch
          Switch(
            value: _timeSlotsProvider.isOfflineMode,
            onChanged: (value) => _timeSlotsProvider.setOfflineMode = value,
          ),
        ],
      ),
    );
  }

  ///[A Loading Progress Indicator widget]
  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  ///[A widget to display error message]
  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
  }

  ///[A Widget to display offline error message]
  Widget _buildOfflineErrorMessage(
    TimeSlotsProvider _timeSlotsProvider,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //mode change
        _buildModeChangingSwitch(_timeSlotsProvider, textTheme),
        //spacing
        SizedBox(height: 42.0),
        //error message
        Center(
          child: Text(_timeSlotsProvider.errorMessage),
        ),
      ],
    );
  }
}
