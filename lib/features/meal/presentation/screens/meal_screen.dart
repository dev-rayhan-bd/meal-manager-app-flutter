import 'package:flutter/material.dart';
import '../../../../app/config/app_colors.dart';
import '../../../../core/providers/app_state_provider.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _memberMeals = [
    {
      'name': 'মোঃ রায়হান',
      'role': 'ম্যানেজার',
      'breakfast': 1.0,
      'lunch': 1.0,
      'dinner': 1.0,
      'totalToday': 3.0,
    },
    {
      'name': 'তানভীর আহমেদ',
      'role': 'সদস্য',
      'breakfast': 1.0,
      'lunch': 0.0,
      'dinner': 1.0,
      'totalToday': 2.0,
    },
    {
      'name': 'সাকিব হাসান',
      'role': 'সদস্য',
      'breakfast': 0.5,
      'lunch': 1.0,
      'dinner': 1.0,
      'totalToday': 2.5,
    },
    {
      'name': 'আরিফ হোসেন',
      'role': 'সদস্য',
      'breakfast': 1.0,
      'lunch': 1.0,
      'dinner': 0.0,
      'totalToday': 2.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;
    final isDark = appState.isDarkMode;

    final double totalTodayMeals = _memberMeals.fold(
      0.0,
      (sum, item) => sum + (item['totalToday'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(appState.tr('daily_meals')),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2025),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() => _selectedDate = picked);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Indicator Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                gradient: AppColors.oceanGradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appState.tr('today_meals'),
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$totalTodayMeals ${appState.tr('items')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appState.tr('members_today'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: Text(appState.isEnglish ? 'Bulk Add' : 'সব একসাথ'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Member Meal Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _memberMeals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = _memberMeals[index];
                return _buildMemberMealCard(member, index, isDark, appState);
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberMealCard(
      Map<String, dynamic> member, int index, bool isDark, AppState appState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  (member['name'] as String)[0],
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      member['role'],
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${appState.tr('total')}: ${member['totalToday']} ${appState.tr('items')}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 24,
            color: isDark ? AppColors.darkBorder : AppColors.border,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMealCounter(appState.tr('breakfast'), member['breakfast'], isDark, (val) {
                setState(() {
                  _memberMeals[index]['breakfast'] = val;
                  _recalculateTotal(index);
                });
              }),
              _buildMealCounter(appState.tr('lunch'), member['lunch'], isDark, (val) {
                setState(() {
                  _memberMeals[index]['lunch'] = val;
                  _recalculateTotal(index);
                });
              }),
              _buildMealCounter(appState.tr('dinner'), member['dinner'], isDark, (val) {
                setState(() {
                  _memberMeals[index]['dinner'] = val;
                  _recalculateTotal(index);
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  void _recalculateTotal(int index) {
    final m = _memberMeals[index];
    _memberMeals[index]['totalToday'] =
        (m['breakfast'] as double) + (m['lunch'] as double) + (m['dinner'] as double);
  }

  Widget _buildMealCounter(
      String label, double count, bool isDark, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (count >= 0.5) onChanged(count - 0.5);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurfaceSubtle : AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.remove,
                  size: 16,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
            ),
            InkWell(
              onTap: () => onChanged(count + 0.5),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, size: 16, color: AppColors.primary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
