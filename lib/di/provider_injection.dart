import 'package:get/get.dart';

import './locator.dart';
import '../providers/providers.dart';

void initProviders() {
  //time slots Provider
  TimeSlotsProvider timeSlotsProvider = Get.put(TimeSlotsProvider());
  locator.registerLazySingleton(() => timeSlotsProvider);
}
