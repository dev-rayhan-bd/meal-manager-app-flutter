import 'package:flutter/material.dart';
import '../../../../app/config/app_colors.dart';
import '../../../../core/providers/app_state_provider.dart';
import '../../../../core/utils/formatters.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  final List<Map<String, dynamic>> _expenses = const [
    {
      'title': 'দৈনিক বাজার (মুরগি ও সবজি)',
      'payer': 'তানভীর আহমেদ',
      'category': 'বাজার',
      'amount': 1250.00,
      'date': '১৫ সেপ্টেম্বর, ২০২৬',
      'icon': Icons.shopping_basket_rounded,
      'color': AppColors.accent,
    },
    {
      'title': 'মেস বাসা ভাড়া',
      'payer': 'মোঃ রায়হান',
      'category': 'ফিক্সড',
      'amount': 14000.00,
      'date': '০১ সেপ্টেম্বর, ২০২৬',
      'icon': Icons.home_rounded,
      'color': AppColors.primary,
    },
    {
      'title': 'ওয়াইফাই ও কারেন্ট বিল',
      'payer': 'সাকিব হাসান',
      'category': 'ইউটিলিটি',
      'amount': 2200.00,
      'date': '০৫ সেপ্টেম্বর, ২০২৬',
      'icon': Icons.bolt_rounded,
      'color': AppColors.warning,
    },
    {
      'title': 'বুয়ার বেতন',
      'payer': 'আরিফ হোসেন',
      'category': 'ফিক্সড',
      'amount': 4000.00,
      'date': '১০ সেপ্টেম্বর, ২০২৬',
      'icon': Icons.person_rounded,
      'color': AppColors.coral,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;
    final isDark = appState.isDarkMode;

    final double totalExpense = _expenses.fold(
      0.0,
      (sum, item) => sum + (item['amount'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(appState.tr('expense_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${appState.tr('new_expense')} model tapped')),
            );
          },
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.add_rounded, color: Colors.white),
          label: Text(
            appState.tr('new_expense'),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 600));
        },
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Expense Overview Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.sunsetGradient,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.coral.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appState.isEnglish ? 'Total Monthly Expense' : 'চলতি মাসের সর্বমোট খরচ',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'September 2026',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      Formatters.formatCurrency(totalExpense),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 0.68,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${appState.tr('budget_used')}: ৬৮%',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '${appState.tr('remaining')}: ৳৮,৫০০.০০',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                appState.tr('recent_expenses'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _expenses.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _expenses[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.border,
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Paid by: ${item['payer']} • ${item['date']}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          Formatters.formatCurrency(item['amount'] as double),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: item['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
