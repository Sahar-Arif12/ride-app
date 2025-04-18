

import 'package:ride_app/features/ride_history/domain/entities/ride.dart';

class GroupedRides {
  final String dateLabel; // e.g., "11 Nov"
  final List<Ride> rides;

  GroupedRides({required this.dateLabel, required this.rides});
}
