import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_app/features/ride_history/data/datasources/ride_local_datasource.dart';
import 'package:ride_app/features/ride_history/data/repositories/ride_repository_impl.dart';
import 'package:ride_app/features/ride_history/domain/usecases/get_rides_grouped_by_date.dart';
import 'package:ride_app/features/ride_history/presentation/bloc/ride_bloc.dart';
import 'package:ride_app/features/ride_history/presentation/bloc/ride_event.dart';
import 'package:ride_app/features/ride_history/presentation/screens/ride_history_screen.dart';


void main() {
  final localDataSource = RideLocalDataSource();
  final repository = RideRepositoryImpl(localDataSource);
  final getRidesGroupedByDate = GetRidesGroupedByDate(repository);

  runApp(MyApp(getRidesGroupedByDate));
}

class MyApp extends StatelessWidget {
  final GetRidesGroupedByDate getRidesGroupedByDate;

  const MyApp(this.getRidesGroupedByDate, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => RideBloc(getRidesGroupedByDate)..add(LoadRides()),
        child: const RideHistoryScreen(),
      ),
    );
  }
}
