import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterChips(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _ExploreCard(name: 'Paris, France', sub: 'City of Light · Europe', price: '\$2,500', emoji: '🗼', rating: '4.9', color: Colors.amber),
                _ExploreCard(name: 'Tokyo, Japan', sub: 'Modern Meets Ancient · Asia', price: '\$2,800', emoji: '⛩️', rating: '4.8', color: Colors.orange),
                _ExploreCard(name: 'Bali, Indonesia', sub: 'Island Paradise · Asia', price: '\$1,100', emoji: '🌴', rating: '4.7', color: Colors.teal),
                _ExploreCard(name: 'New York, USA', sub: 'The Big Apple · Americas', price: '\$3,800', emoji: '🗽', rating: '4.8', color: Colors.blue),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore 🌍',
                style: GoogleFonts.fraunces(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray800,
                ),
              ),
              const Icon(Icons.tune, color: AppColors.gray600),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.gray400, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Search destinations...',
                  style: TextStyle(fontSize: 13, color: AppColors.gray400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _Chip(label: 'All', isActive: true),
          _Chip(label: '🏖️ Beach'),
          _Chip(label: '🏙️ City'),
          _Chip(label: '⛰️ Nature'),
          _Chip(label: '💰 Budget'),
          _Chip(label: '✨ Luxury'),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isActive;
  const _Chip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.g600 : AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: isActive ? AppColors.g600 : AppColors.gray200),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: isActive ? AppColors.white : AppColors.gray600,
        ),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final String name;
  final String sub;
  final String price;
  final String emoji;
  final String rating;
  final Color color;
  const _ExploreCard({required this.name, required this.sub, required this.price, required this.emoji, required this.rating, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            color: color.withOpacity(0.15),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 32))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.gray400)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.coral, size: 14),
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.coral)),
                        ],
                      ),
                      Text('from $price', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.g700)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
