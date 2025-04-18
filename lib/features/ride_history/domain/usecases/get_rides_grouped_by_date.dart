
import 'package:ride_app/features/ride_history/domain/models/grouped_rides.dart';

import '../entities/ride.dart';
import '../repositories/ride_repository.dart';

class GetRidesGroupedByDate {
  final RideRepository repository;

  GetRidesGroupedByDate(this.repository);

  Future<List<GroupedRides>> call() async {
    final rides = await repository.getRides();

    final grouped = <String, List<Ride>>{};

    for (var ride in rides) {
      final date = "${ride.creationTime.day} "
                   "${_monthName(ride.creationTime.month)}";

      grouped.putIfAbsent(date, () => []).add(ride);
    }

    return grouped.entries.map((e) => GroupedRides(
      dateLabel: e.key,
      rides: e.value,
    )).toList();
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}
