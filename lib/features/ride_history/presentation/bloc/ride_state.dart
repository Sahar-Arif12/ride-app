import '../../domain/models/grouped_rides.dart';

abstract class RideState {}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RideLoaded extends RideState {
  final List<GroupedRides> groupedRides;
  RideLoaded(this.groupedRides);
}

class RideError extends RideState {
  final String message;
  RideError(this.message);
}
