import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/trip_provider.dart';
import '../../core/theme.dart';
import '../itinerary/itinerary_view.dart';

class MyTripsView extends StatefulWidget {
  const MyTripsView({super.key});

  @override
  State<MyTripsView> createState() => _MyTripsViewState();
}

class _MyTripsViewState extends State<MyTripsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripProvider>(context, listen: false).fetchTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final trips = tripProvider.trips;

    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: tripProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : trips.isEmpty
                    ? const Center(child: Text('No trips found.', style: TextStyle(color: AppColors.gray400)))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          return _MyTripCard(trip: trips[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Trips ✈️',
            style: GoogleFonts.fraunces(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.gray800,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.g500, AppColors.g700]),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: AppColors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _TabItem(label: 'Upcoming', isActive: true),
          _TabItem(label: 'Past'),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  const _TabItem({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive 
            ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
            : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isActive ? AppColors.g700 : AppColors.gray400,
          ),
        ),
      ),
    );
  }
}

class _MyTripCard extends StatelessWidget {
  final dynamic trip;

  const _MyTripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final name = trip['destination'] ?? 'Unknown';
    final startDate = trip['start_date']?.toString().split('T').first ?? '';
    final budget = '\$${(double.tryParse(trip['budget']?.toString() ?? '0') ?? 0).toStringAsFixed(0)}';
    final progress = 0.35; // Mock progress for now
    final emoji = '🌏';
    final color = AppColors.g700;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.white),
                    ),
                    Text(
                      startDate,
                      style: TextStyle(fontSize: 11, color: AppColors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Budget: $budget',
                      style: const TextStyle(fontSize: 10, color: AppColors.gray400, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Active · ${(progress * 100).toInt()}%',
                      style: const TextStyle(fontSize: 10, color: AppColors.gray400, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.gray100,
                  valueColor: AlwaysStoppedAnimation(progress < 0.2 ? Colors.amber : AppColors.g500),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ItineraryView(trip: trip))),
                        child: const _BtnSm(label: '👁️ View', isPrimary: true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const _BtnSm(label: '✏️ Edit'),
                    const SizedBox(width: 8),
                    const _BtnSm(label: '🤖 AI'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BtnSm extends StatelessWidget {
  final String label;
  final bool isPrimary;
  const _BtnSm({required this.label, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.g50 : AppColors.gray50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isPrimary ? AppColors.g300 : AppColors.gray200),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: isPrimary ? AppColors.g700 : AppColors.gray600,
          ),
        ),
      ),
    );
  }
}
