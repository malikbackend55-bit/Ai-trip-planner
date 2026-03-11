import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class ItineraryView extends StatelessWidget {
  const ItineraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDayHeader('Day 1', 'Tuesday, Jul 1', '⛅ 22°C'),
                const _ActivityCard(
                  time: '🌅',
                  name: 'Eiffel Tower Visit',
                  place: '📍 Champ de Mars, 7th Arr.',
                  meta: ['⏱ 2h', 'Morning'],
                  cost: '\$25',
                  color: AppColors.sand,
                ),
                const _ActivityCard(
                  time: '☀️',
                  name: 'Louvre Museum',
                  place: '📍 Rue de Rivoli, 1st Arr.',
                  meta: ['⏱ 3h', 'Afternoon'],
                  cost: '\$20',
                  color: Color(0xfffef3c7),
                ),
                const _ActivityCard(
                  time: '🌙',
                  name: 'Dinner at Le Marais',
                  place: '📍 Rue de Bretagne, 3rd',
                  meta: ['⏱ 2h', 'Evening'],
                  cost: '\$60',
                  color: Color(0xffede9fe),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.g600,
        child: const Text('🤖', style: TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Hero(
      tag: 'trip_paris',
      child: Material(
        color: AppColors.g800,
        child: Container(
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: AppColors.white)),
                  const Text('⬆️ Share', style: TextStyle(color: AppColors.g300, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '🇫🇷 Paris, France',
                style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              const SizedBox(height: 4),
              const Text(
                '📅 Jul 1 – Jul 10, 2025  ·  👥 2 people',
                style: TextStyle(fontSize: 11, color: AppColors.g300, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16),
              _buildTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          _TabItem(label: 'Overview', isActive: true),
          _TabItem(label: 'Map 🗺️'),
          _TabItem(label: 'Budget 💰'),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String label, String date, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.g600, borderRadius: BorderRadius.circular(999)),
            child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.white)),
          ),
          const SizedBox(width: 10),
          Text(date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.gray600)),
          const Spacer(),
          Text(status, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String time;
  final String name;
  final String place;
  final List<String> meta;
  final String cost;
  final Color color;

  const _ActivityCard({required this.time, required this.name, required this.place, required this.meta, required this.cost, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.gray100)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 32, height: 32, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(time, style: const TextStyle(fontSize: 16)))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.gray800)),
                Text(place, style: const TextStyle(fontSize: 10, color: AppColors.gray400)),
                const SizedBox(height: 8),
                Row(
                  children: meta.map((m) => Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: AppColors.gray50, borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.gray100)),
                    child: Text(m, style: const TextStyle(fontSize: 9, color: AppColors.gray600, fontWeight: FontWeight.bold)),
                  )).toList(),
                ),
              ],
            ),
          ),
          Text(cost, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.g700)),
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
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: isActive ? AppColors.white : Colors.transparent, borderRadius: BorderRadius.circular(8)), child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isActive ? AppColors.g800 : AppColors.white.withOpacity(0.6)))));
}
