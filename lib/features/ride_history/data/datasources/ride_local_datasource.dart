import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ride_model.dart';

class RideLocalDataSource {
  Future<List<RideModel>> getRidesFromJson() async {
    final jsonString = await rootBundle.loadString('assets/rides.json');
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((e) => RideModel.fromJson(e)).toList();
  }
}
