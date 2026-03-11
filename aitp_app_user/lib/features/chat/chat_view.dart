import 'package:flutter/material.dart';
import '../../core/theme.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _ChatBubble(
                  isAi: true,
                  text: 'Hey! I\'m your AI travel assistant 🌍 Tell me where you\'d like to go and I\'ll plan the perfect trip!',
                ),
                _ChatBubble(
                  isAi: false,
                  text: 'Plan a 9-day trip to Paris for 2 people, budget \$3500',
                ),
                _ChatBubble(
                  isAi: true,
                  text: 'Perfect! 🗼 Paris is a great choice! I\'ve created a detailed 9-day itinerary covering the Eiffel Tower, Louvre, Versailles & more. Shall I show it?',
                ),
                _ChatBubble(
                  isAi: false,
                  text: 'Yes! And add some vegetarian restaurants',
                ),
                _ChatBubble(
                  isAi: true,
                  text: '✅ Updated! I\'ve added 5 top vegetarian spots including Le Grenier de Notre-Dame and Bob\'s Kitchen. Your itinerary is ready! 🥗',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          _buildQuickReplies(),
          _buildInputBar(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.g700, AppColors.g800]),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.g400, AppColors.g600]),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white.withOpacity(0.3), width: 2),
            ),
            child: const Center(child: Text('🤖', style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'AITP Assistant',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.white),
              ),
              Text(
                '🟢 Online · Powered by Gemini',
                style: TextStyle(fontSize: 10, color: AppColors.g300),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert, color: AppColors.white),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _QrChip(label: '🌦️ Check weather'),
          _QrChip(label: '💰 Budget tips'),
          _QrChip(label: '🏨 Best hotels'),
          _QrChip(label: '📅 Change dates'),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray100)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.gray200),
              ),
              child: const Text('Ask anything about your trip...', style: TextStyle(fontSize: 12, color: AppColors.gray400)),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.mic, color: AppColors.gray600, size: 24),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.g500, AppColors.g700]),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send, color: AppColors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isAi;
  final String text;
  const _ChatBubble({required this.isAi, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAi) _Avatar(isAi: true),
          const SizedBox(width: 8),
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isAi ? AppColors.white : AppColors.g600,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isAi ? 4 : 16),
                bottomRight: Radius.circular(isAi ? 16 : 4),
              ),
              boxShadow: isAi ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] : null,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isAi ? AppColors.gray800 : AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (!isAi) _Avatar(isAi: false),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final bool isAi;
  const _Avatar({required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isAi ? AppColors.g100 : AppColors.gray200,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(isAi ? '🤖' : '👤', style: const TextStyle(fontSize: 16))),
    );
  }
}

class _QrChip extends StatelessWidget {
  final String label;
  const _QrChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.g300),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.g700),
      ),
    );
  }
}
