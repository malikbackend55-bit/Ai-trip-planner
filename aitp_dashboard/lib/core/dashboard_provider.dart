import 'package:flutter/material.dart';
import 'api_service.dart';

class DashboardProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Map<String, dynamic> _stats = {};
  List<dynamic> _users = [];
  List<dynamic> _trips = [];
  bool _isLoading = false;

  Map<String, dynamic> get stats => _stats;
  List<dynamic> get users => _users;
  List<dynamic> get trips => _trips;
  bool get isLoading => _isLoading;

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    try {
      final statsRes = await _apiService.getAdminStats();
      final usersRes = await _apiService.getAdminUsers();
      final tripsRes = await _apiService.getTrips();
      
      _stats = statsRes.data;
      _users = usersRes.data;
      _trips = tripsRes.data;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
