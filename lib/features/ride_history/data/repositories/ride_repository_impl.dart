

import '../../domain/entities/ride.dart';
import '../../domain/repositories/ride_repository.dart';
import '../datasources/ride_local_datasource.dart';

class RideRepositoryImpl implements RideRepository {
  final RideLocalDataSource localDataSource;

  RideRepositoryImpl(this.localDataSource);

@override
Future<List<Ride>> getRides() async {
  final rideModels = await localDataSource.getRidesFromJson();
  return rideModels.map((model) => model.toEntity()).toList();
}

}
