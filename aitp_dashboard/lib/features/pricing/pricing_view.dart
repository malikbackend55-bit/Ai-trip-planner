import 'package:flutter/material.dart';
import '../../core/theme.dart';

class PricingView extends StatefulWidget {
  const PricingView({super.key});

  @override
  State<PricingView> createState() => _PricingViewState();
}

class _PricingViewState extends State<PricingView> with SingleTickerProviderStateMixin {
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pricing Tiers', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textMain)),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Tier'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildPricingCards(),
        ],
      ),
    );
  }

  Widget _buildPricingCards() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPlanCard(
          title: 'Basic',
          price: 'Free',
          description: 'Standard trip planning with basic AI.',
          features: ['Up to 3 trips/month', 'Standard Support', 'Basic AI Generation'],
          isPopular: false,
        ),
        const SizedBox(width: 24),
        _buildPlanCard(
          title: 'Premium',
          price: '\$9.99/mo',
          description: 'Advanced travel plans with unlimited AI.',
          features: ['Unlimited trips', 'Priority Support', 'Advanced AI Generation', 'Export Itineraries'],
          isPopular: true,
        ),
        const SizedBox(width: 24),
        _buildPlanCard(
          title: 'Pro Family',
          price: '\$19.99/mo',
          description: 'For families and groups traveling together.',
          features: ['Everything in Premium', 'Group Collaboration', 'Shared Expenses Tracking', 'Custom Branding'],
          isPopular: false,
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required bool isPopular,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isPopular ? AppColors.accent : AppColors.border, width: isPopular ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPopular)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('🌟 Most Popular', style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain)),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(fontSize: 14, color: AppColors.textDim)),
            const SizedBox(height: 24),
            ...features.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.success, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f, style: const TextStyle(fontSize: 14))),
                ],
              ),
            )),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPopular ? AppColors.accent : AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Edit Tier'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
