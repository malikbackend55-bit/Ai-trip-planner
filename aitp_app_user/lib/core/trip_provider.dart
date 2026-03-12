import 'package:flutter/material.dart';
import 'api_service.dart';

class TripProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _trips = [];
  bool _isLoading = false;

  List<dynamic> get trips => _trips;
  bool get isLoading => _isLoading;

  Future<void> fetchTrips() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.getTrips();
      _trips = response.data;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createTrip(Map<String, dynamic> data) async {
    try {
      await _apiService.createTrip(data);
      await fetchTrips();
      return true;
    } catch (e) {
      return false;
    }
  }
}
