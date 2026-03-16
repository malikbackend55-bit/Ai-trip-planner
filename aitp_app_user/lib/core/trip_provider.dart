import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
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
      debugPrint('Error fetching trips: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> generateTrip(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.generateTrip(data);
      await fetchTrips();
      _isLoading = false;
      notifyListeners();
      return null; // Success, no error
    } on DioException catch (e) {
      _isLoading = false;
      notifyListeners();
      return _extractErrorMessage(e);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  String _extractErrorMessage(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        if (data.containsKey('message')) return data['message'];
        if (data.containsKey('error')) return data['error'];
      }
    }
    return 'A network error occurred: ${e.message}';
  }
}

final tripProvider = ChangeNotifierProvider<TripProvider>((ref) => TripProvider());
