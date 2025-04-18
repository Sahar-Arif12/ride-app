import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_app/features/ride_history/domain/entities/ride.dart';
import '../bloc/ride_bloc.dart';
import '../bloc/ride_event.dart';
import '../bloc/ride_state.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // Remove AppBar space
        child: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<RideBloc, RideState>(
        builder: (context, state) {
          if (state is RideLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RideError) {
            return Center(child: Text(state.message));
          } else if (state is RideLoaded) {
            final groups = state.groupedRides;

            return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, groupIndex) {
                final group = groups[groupIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: Text(
                        group.dateLabel,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...group.rides.map((Ride ride) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Center(
                                    child: _getVehicleIcon(ride),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ride.pickupLocation,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ride.dropOffLocation,
                                        style: const TextStyle(
                                         color: Color.fromARGB(255, 40, 36, 36),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _formatTime(ride.creationTime),
                                            style: const TextStyle(
                                              color: Color.fromARGB(255, 40, 36, 36),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                          Text(
                                            _formatPrice(
                                              double.tryParse(ride.priceText.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0,
                                            ),  
  style: const TextStyle(
    color: Color.fromARGB(255, 40, 36, 36),
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),


                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            );
          }

          return const Center(child: Text("No ride history available."));
        },
      ),
    );
  }

  Widget _getVehicleIcon(Ride ride) {
    if (ride.dropOffLocation.contains('Victory House')) {
      return const Text(
        '🌮',
        style: TextStyle(fontSize: 42),
      );
    } else {
      return const Icon(
        Icons.directions_car,
        size: 42,
        color: Colors.black54,
      );
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
  String _formatPrice(double price) {
  if (price % 1 == 0) {
    return '\$${price.toInt()}';
  } else {
    return '\$${price.toStringAsFixed(2)}';
  }
}

}