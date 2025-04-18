import 'package:equatable/equatable.dart';
abstract class RideEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRides extends RideEvent {}
