import 'package:flutter/material.dart';
import '../../../../app/config/app_colors.dart';
import '../../../../core/providers/app_state_provider.dart';
import '../../../../core/utils/formatters.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  final List<Map<String, dynamic>> _members = const [
    {
      'name': 'মোঃ রায়হান',
      'role': 'মেস ম্যানেজার',
      'phone': '+৮৮০ ১৭০০০-০০০০০',
      'deposit': 5000.00,
      'totalMeal': 45.0,
      'estExpense': 1822.50,
      'balance': 3177.50,
      'isAdvance': true,
    },
    {
      'name': 'তানভীর আহমেদ',
      'role': 'সদস্য',
      'phone': '+৮৮০ ১৮০০০-০০০০০',
      'deposit': 4000.00,
      'totalMeal': 42.0,
      'estExpense': 1701.00,
      'balance': 2299.00,
      'isAdvance': true,
    },
    {
      'name': 'সাকিব হাসান',
      'role': 'সদস্য',
      'phone': '+৮৮০ ১৯০০০-০০০০০',
      'deposit': 1500.00,
      'totalMeal': 48.0,
      'estExpense': 1944.00,
      'balance': -444.00,
      'isAdvance': false,
    },
    {
      'name': 'আরিফ হোসেন',
      'role': 'সদস্য',
      'phone': '+৮৮০ ১৬০০০-০০০০০',
      'deposit': 3000.00,
      'totalMeal': 38.0,
      'estExpense': 1539.00,
      'balance': 1461.00,
      'isAdvance': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;
    final isDark = appState.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('${appState.tr('members_title')} (${_members.length})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 600));
        },
        color: AppColors.primary,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 110),
          itemCount: _members.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final member = _members[index];
            final bool isAdvance = member['isAdvance'] as bool;
            final double balance = (member['balance'] as double).abs();

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isAdvance
                      ? AppColors.success.withValues(alpha: 0.4)
                      : AppColors.error.withValues(alpha: 0.4),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                        child: Text(
                          (member['name'] as String)[0],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  member['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    member['role'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              member['phone'],
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurfaceSubtle : AppColors.surfaceSubtle,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMiniStat(
                          appState.tr('deposit'),
                          Formatters.formatCurrency(member['deposit']),
                          isDark,
                        ),
                        _buildMiniStat(
                          appState.tr('total_meals'),
                          '${member['totalMeal']} ${appState.tr('items')}',
                          isDark,
                        ),
                        _buildMiniStat(
                          isAdvance ? appState.tr('advance') : appState.tr('due'),
                          Formatters.formatCurrency(balance),
                          isDark,
                          color: isAdvance ? AppColors.success : AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, bool isDark, {Color? color}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color ?? (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
