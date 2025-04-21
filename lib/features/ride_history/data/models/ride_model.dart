import '../../domain/entities/ride.dart';

class RideModel {
  final String imageUrl;
  final DateTime creationTime;
  final String pickupLocationText;
  final String dropOffLocationText;
  final String priceText;

  RideModel({
    required this.imageUrl,
    required this.creationTime,
    required this.pickupLocationText,
    required this.dropOffLocationText,
    required this.priceText,
  });

 factory RideModel.fromJson(Map<String, dynamic> json) {
  return RideModel(
    imageUrl: json['imageUrl'] ?? '',
    creationTime: DateTime.tryParse(json['creationTime'] ?? '') ?? DateTime.now(),
    pickupLocationText: json['pickupLocationText'] ?? '',
    dropOffLocationText: json['dropOffLocationText'] ?? '',
    priceText: json['priceText'] ?? '',
  );
}

Ride toEntity() {
  return Ride(
    imageUrl: imageUrl,
    creationTime: creationTime,
    pickupLocation: pickupLocationText,
    dropOffLocation: dropOffLocationText,
    pickupLocationText: pickupLocationText,
    dropOffLocationText: dropOffLocationText,
    priceText: priceText,
  );
}

}
