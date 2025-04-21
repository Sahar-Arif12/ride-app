import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ride_model.dart';

class RideLocalDataSource {
 Future<List<RideModel>> getRidesFromJson() async {
  try {
    // Print the available assets to check if your file is accessible
    print("Attempting to load rides.json");
    
    final jsonString = await rootBundle.loadString('assets/rides.json');
    print("JSON loaded, length: ${jsonString.length}");
    
    final List<dynamic> decoded = json.decode(jsonString);
    print("JSON decoded, found ${decoded.length} items");
    
    final models = decoded.map((e) => RideModel.fromJson(e)).toList();
    print("Created ${models.length} ride models");
    
    return models;
  } catch (e, stackTrace) {
    print('Error loading rides from JSON: $e');
    print('Stack trace: $stackTrace');
    
    // Re-throw for debugging in development
    // In production, you might want to return [] instead
    throw e;
  }
}
}
