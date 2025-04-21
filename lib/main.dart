import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_app/features/ride_history/data/datasources/ride_local_datasource.dart';
import 'package:ride_app/features/ride_history/data/repositories/ride_repository_impl.dart';
import 'package:ride_app/features/ride_history/domain/usecases/get_rides_grouped_by_date.dart';
import 'package:ride_app/features/ride_history/presentation/bloc/ride_bloc.dart';
import 'package:ride_app/features/ride_history/presentation/bloc/ride_event.dart';
import 'package:ride_app/features/ride_history/presentation/screens/ride_history_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RideBloc>(
          create: (context) {
            // Setup dependencies
            final dataSource = RideLocalDataSource();
            final repository = RideRepositoryImpl(dataSource);
            final useCase = GetRidesGroupedByDate(repository);
            
            // Create bloc and immediately load rides
            final bloc = RideBloc(useCase);
            bloc.add(LoadRides());
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Ride History App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RideHistoryScreen(),
      ),
    );
  }
}