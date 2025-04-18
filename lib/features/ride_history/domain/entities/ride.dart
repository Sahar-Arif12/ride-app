class Ride {
  final String imageUrl;
  final DateTime creationTime;
  final String pickupLocation;
  final String dropOffLocation;
  final String pickupLocationText;
  final String dropOffLocationText;
  final String priceText;

  Ride({
    required this.imageUrl,
    required this.creationTime,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.pickupLocationText,
    required this.dropOffLocationText,
    required this.priceText,
  });
}
