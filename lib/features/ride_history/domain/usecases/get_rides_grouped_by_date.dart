import 'package:ride_app/features/ride_history/domain/models/grouped_rides.dart';
import '../entities/ride.dart';
import '../repositories/ride_repository.dart';
import 'package:intl/intl.dart';


class GetRidesGroupedByDate {
  final RideRepository repository;

  GetRidesGroupedByDate(this.repository);
Future<List<GroupedRides>> call() async {
  try {
    final rides = await repository.getRides();

    if (rides.isEmpty) {
      return [];
    }
    

    final Map<String, List<Ride>> grouped = {};
   
    for (var ride in rides) {
   
      final dateTime = ride.creationTime;
      if (dateTime == null) continue;
      
      final date = DateFormat('d MMM').format(dateTime);
      

      (grouped[date] ??= []).add(ride);
    }
    

    final result = grouped.entries.map((entry) {
      return GroupedRides(
        dateLabel: entry.key,
        rides: entry.value..sort((a, b) {
   
          final aTime = a.creationTime ?? DateTime.fromMillisecondsSinceEpoch(0);
          final bTime = b.creationTime ?? DateTime.fromMillisecondsSinceEpoch(0);
          return bTime.compareTo(aTime); 
        }),
      );
    }).toList();
    

    result.sort((a, b) {
      
      final aRides = a.rides;
      final bRides = b.rides;
      
      if (aRides.isEmpty && bRides.isEmpty) return 0;
      if (aRides.isEmpty) return 1;
      if (bRides.isEmpty) return -1;
      
      final aTime = aRides.first.creationTime ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = bRides.first.creationTime ?? DateTime.fromMillisecondsSinceEpoch(0);
      
      return bTime.compareTo(aTime); // Newest first
    });
    
    return result;
  } catch (e) {
    print('Error grouping rides: $e');
    return [];
  }
}


}