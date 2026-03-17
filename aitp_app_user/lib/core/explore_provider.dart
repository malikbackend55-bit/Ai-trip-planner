import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';

class Destination {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;
  final String rating;
  final Color color;
  final String category;

  Destination({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
    required this.rating,
    required this.color,
    required this.category,
  });
}

class ExploreProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Destination> _allDestinations = [];
  String _searchQuery = '';
  String _activeFilter = 'All';
  bool _isLoading = false;

  List<Destination> get destinations {
    var filtered = _allDestinations;
    if (_activeFilter != 'All') {
      filtered = filtered.where((d) => d.category == _activeFilter).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((d) =>
          d.name.toLowerCase().contains(q) ||
          d.subtitle.toLowerCase().contains(q)).toList();
    }
    return filtered;
  }

  String get searchQuery => _searchQuery;
  String get activeFilter => _activeFilter;
  bool get isLoading => _isLoading;

  ExploreProvider() {
    fetchDestinations();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  Future<void> fetchDestinations() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getDestinations();
      final data = response.data;
      final topDestinations = data['topDestinations'] as List? ?? [];

      _allDestinations = [
        // First populate from backend top destinations
        ...topDestinations.map((d) {
          final dest = d['destination']?.toString() ?? 'Unknown';
          return Destination(
            name: dest,
            subtitle: _getSubtitle(dest),
            price: 'from \$${((double.tryParse(d['count']?.toString() ?? '1') ?? 1) * 500).toStringAsFixed(0)}',
            emoji: _getEmoji(dest),
            rating: '4.${(dest.hashCode % 3) + 7}',
            color: _getColor(dest),
            category: _getCategory(dest),
          );
        }),
        // Add default curated destinations if backend returned fewer than 6
        ..._getDefaultDestinations(),
      ];

      // Remove duplicates by name
      final seen = <String>{};
      _allDestinations = _allDestinations.where((d) => seen.add(d.name.toLowerCase())).toList();
    } catch (e) {
      debugPrint('Error fetching destinations: $e');
      // Fallback to defaults on error
      _allDestinations = _getDefaultDestinations();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Destination> _getDefaultDestinations() {
    return [
      Destination(name: 'Paris, France', subtitle: 'City of Light · Europe', price: 'from \$2,500', emoji: '🗼', rating: '4.9', color: Colors.amber, category: 'City'),
      Destination(name: 'Tokyo, Japan', subtitle: 'Modern Meets Ancient · Asia', price: 'from \$2,800', emoji: '⛩️', rating: '4.8', color: Colors.orange, category: 'City'),
      Destination(name: 'Bali, Indonesia', subtitle: 'Island Paradise · Asia', price: 'from \$1,100', emoji: '🌴', rating: '4.7', color: Colors.teal, category: 'Beach'),
      Destination(name: 'New York, USA', subtitle: 'The Big Apple · Americas', price: 'from \$3,800', emoji: '🗽', rating: '4.8', color: Colors.blue, category: 'City'),
      Destination(name: 'Santorini, Greece', subtitle: 'Blue Domes · Europe', price: 'from \$2,200', emoji: '🏛️', rating: '4.9', color: Colors.indigo, category: 'Beach'),
      Destination(name: 'Swiss Alps', subtitle: 'Mountain Majesty · Europe', price: 'from \$3,200', emoji: '⛰️', rating: '4.8', color: Colors.green, category: 'Nature'),
      Destination(name: 'Maldives', subtitle: 'Tropical Luxury · Asia', price: 'from \$4,500', emoji: '🏝️', rating: '4.9', color: Colors.cyan, category: 'Luxury'),
      Destination(name: 'Marrakech, Morocco', subtitle: 'Desert Oasis · Africa', price: 'from \$900', emoji: '🐪', rating: '4.6', color: Colors.brown, category: 'Budget'),
    ];
  }

  String _getSubtitle(String dest) {
    final lower = dest.toLowerCase();
    if (lower.contains('france') || lower.contains('italy') || lower.contains('spain')) return 'Iconic · Europe';
    if (lower.contains('japan') || lower.contains('bali') || lower.contains('thailand')) return 'Exotic · Asia';
    if (lower.contains('usa') || lower.contains('mexico') || lower.contains('brazil')) return 'Vibrant · Americas';
    return 'Adventure · World';
  }

  String _getEmoji(String dest) {
    final lower = dest.toLowerCase();
    if (lower.contains('paris')) return '🗼';
    if (lower.contains('tokyo')) return '⛩️';
    if (lower.contains('bali')) return '🌴';
    if (lower.contains('new york')) return '🗽';
    if (lower.contains('london')) return '💂';
    if (lower.contains('rome') || lower.contains('italy')) return '🏛️';
    return '🌏';
  }

  Color _getColor(String dest) {
    final lower = dest.toLowerCase();
    if (lower.contains('paris')) return Colors.amber;
    if (lower.contains('tokyo')) return Colors.orange;
    if (lower.contains('bali')) return Colors.teal;
    if (lower.contains('new york')) return Colors.blue;
    return Colors.green;
  }

  String _getCategory(String dest) {
    final lower = dest.toLowerCase();
    if (lower.contains('bali') || lower.contains('beach') || lower.contains('maldives')) return 'Beach';
    if (lower.contains('alps') || lower.contains('mountain') || lower.contains('forest')) return 'Nature';
    return 'City';
  }
}

final exploreProvider = ChangeNotifierProvider<ExploreProvider>((ref) => ExploreProvider());
