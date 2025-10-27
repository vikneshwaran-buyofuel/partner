import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/inputs/custom_progressBar.dart';
import 'package:partner/core/constants/app_colors.dart';

class FinancialOverview extends StatelessWidget {
  final double utilised;
  final double total;
  final double profitsEarned;
  final double unrealisedProfits;
  final VoidCallback? onViewFullFinancials;

  const FinancialOverview({
    Key? key,
    required this.utilised,
    required this.total,
    required this.profitsEarned,
    required this.unrealisedProfits,
    this.onViewFullFinancials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: const Text(
                    'Financial Overview',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1a1a1a),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
          
                // Budget Usage
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 20, color: Color(0xFF1a1a1a)),
                    children: [
                      TextSpan(
                        text: '₹${utilised.toStringAsFixed(2)}L',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' Utilised out of '),
                      TextSpan(
                        text: '₹${total.toStringAsFixed(2)}L',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
          
                // Progress Bar
                CustomProgressBar(
                  value: 60,
                  maxValue: 100,
                  progressGradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                  ),
                ),
          
                const SizedBox(height: 32),
          
                // Profits Section
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profits Earned',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${profitsEarned.toStringAsFixed(2)}L',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1a1a1a),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unrealised Profits',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₹${unrealisedProfits.toStringAsFixed(2)}L',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1a1a1a),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
           InkWell(
              onTap: onViewFullFinancials,

              child: Container(
                width: double.infinity,
                height: 43,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View Full Financials',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      LucideIcons.chevronRight,
                      color: Colors.white,
                      size: 24,
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
