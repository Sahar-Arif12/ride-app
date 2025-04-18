import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ride_app/features/ride_history/domain/usecases/get_rides_grouped_by_date.dart';

import 'ride_event.dart';
import 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final GetRidesGroupedByDate getRidesGroupedByDate;

  RideBloc(this.getRidesGroupedByDate) : super(RideInitial()) {
    on<LoadRides>((event, emit) async {
      emit(RideLoading());
      try {
        final grouped = await getRidesGroupedByDate();
        emit(RideLoaded(grouped));
      } catch (_) {
        emit(RideError('Failed to load ride history'));
      }
    });
  }
}
